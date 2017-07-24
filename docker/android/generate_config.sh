#!/bin/bash

node_config_json="node_config.json"

if [ -z "$PLATFORM_NAME" ]; then
  PLATFORM_NAME="Android"
fi

if [ -z "$APPIUM_HOST" ]; then
  APPIUM_HOST="127.0.0.1"
fi

if [ -z "$APPIUM_PORT" ]; then
  APPIUM_PORT=4723
fi

if [ -z "$SELENIUM_HOST" ]; then
  SELENIUM_HOST="172.17.0.2"
fi

if [ -z "$SELENIUM_PORT" ]; then
  SELENIUM_PORT=4444
fi

if [ -z "$BROWSER_NAME" ]; then
  BROWSER_NAME="android"
fi

if [ -z "$UDID" ]; then
  # docker ps | grep "thedrhax/android-avd" | head -n1 | awk '{print $1}' --> Get the ID of the device container
  # docker exec -it <container-name-or-id> bash --> Execute a command within a running container 
  # ls -l /dev/disk/by-uuid | grep dm-1 | awk '{print $9}' --> Get the UDID of the emulated device
  UDID=`docker exec -it $(docker ps | grep "thedrhax/android-avd" | head -n1 | awk '{print $1}') bash && ls -l /dev/disk/by-uuid | grep dm-1 | awk '{print $9}'`
fi

#Get device names
devices=($(adb devices | grep -oP "\K(\w+)(?=\sdevice(\W|$))"))

#Create capabilities json configs
function create_capabilities() {
  capabilities=""
  for name in ${devices[@]}; do
    os_version="$(adb -s $name shell getprop ro.build.version.release | tr -d '\r')"
    capabilities+=$(cat <<_EOF
{
    "platform": "$PLATFORM_NAME",
    "platformName": "$PLATFORM_NAME",
    "version": "$os_version",
    "browserName": "$BROWSER_NAME",
    "deviceName": "$name",
    "udid": "$UDID",
    "maxInstances": 1
  }
_EOF
    )
    if [ ${devices[-1]} != $name ]; then
      capabilities+=', '
    fi
  done
  echo "$capabilities"
}

#Final node configuration json string
nodeconfig=$(cat <<_EOF
{
  "capabilities": [$(create_capabilities)],
  "configuration": {
    "cleanUpCycle": 2000,
    "timeout": 30000,
    "proxy": "org.openqa.grid.selenium.proxy.DefaultRemoteProxy",
    "url": "http://$APPIUM_HOST:$APPIUM_PORT/wd/hub",
    "host": "$APPIUM_HOST",
    "port": $APPIUM_PORT,
    "maxSession": 6,
    "register": true,
    "registerCycle": 5000,
    "hubHost": "$SELENIUM_HOST",
    "hubPort": $SELENIUM_PORT
  }
}
_EOF
)
echo "$nodeconfig" > $node_config_json