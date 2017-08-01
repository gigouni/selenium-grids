#!/bin/bash

node_config_json="node_config.json"

echo "Generating config..."

if [ -z "$PLATFORM_NAME" ];   then PLATFORM_NAME="Android"; fi
if [ -z "$OS_VERSION" ];      then echo "Empty OS_VERSION for the device Android"; fi
if [ -z "$APPIUM_HOST" ];     then APPIUM_HOST="10.0.2.15"; fi
if [ -z "$APPIUM_PORT" ];     then APPIUM_PORT=4723; fi
if [ -z "$SELENIUM_HOST" ];   then SELENIUM_HOST="172.17.0.2"; fi
if [ -z "$SELENIUM_PORT" ];   then SELENIUM_PORT=4444; fi
if [ -z "$BROWSER_NAME" ];    then BROWSER_NAME="android"; fi
if [ -z "$MAX_INSTANCES" ];   then MAX_INSTANCES=1; fi

# Here why the default value of the Appium host
# https://developer.android.com/studio/run/emulator-networking.html

# The device management is way more complex to handle dependings on the thrown error
if [ -z "$DEVICE_NAME" ];     then 
  echo "Empty device name for the device Android. The script won't be able to continue"
  exit 1
elif [ "$DEVICE_NAME" = "*" ] ; then
  echo "The ADB server failed running and need to restart. It will do it by itself right now"
  DEVICE_NAME="$(adb devices | head -n2 | tail -n1 | awk '{print $1}')"
  echo "Caught $DEVICE_NAME as the device name"
elif [ "$DEVICE_NAME" = "error: device offline" ] ; then
  echo "The device crashes and need to restart. The script won't be able to continue"
  exit 1
fi

nodeconfig=$(cat <<_EOF
{
  "capabilities": [{
    "platform": "$PLATFORM_NAME",
    "platformName": "$PLATFORM_NAME",
    "version": "$OS_VERSION",
    "browserName": "$BROWSER_NAME",
    "deviceName": "$DEVICE_NAME",
    "maxInstances": "$MAX_INSTANCES"
  }],
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

echo "Generated capabilities: [$nodeconfig]"
echo "Generation done"

echo "$nodeconfig" > $node_config_json