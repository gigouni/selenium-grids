#!/bin/bash
#### Description: Script to automatize the default run process
#### Author: Nicolas GIGOU <nicolas.gigou@telecomsante.com>

CONNECT_TO_GRID=true
echo "Connection to the grid starting..."

PLATFORM_NAME="Android"
echo "--- Adding a node for an $PLATFORM_NAME device"

APPIUM_HOST=127.0.0.1
APPIUM_PORT=4723
echo "--- Caught $APPIUM_HOST:$APPIUM_PORT as the Appium IP address"

SELENIUM_HOST=$(docker inspect $(docker ps | grep "selenium/hub" | awk '{print $1}') | grep "\"IPAddress\"" | head -n1 | awk '{print $2}' | tr -d \" | tr -d \,)
SELENIUM_PORT=4444
echo "--- Caught $SELENIUM_HOST:$SELENIUM_PORT as the Selenium IP address"

BROWSER_NAME="android"
echo "--- The tests will run on the $BROWSER_NAME browser"

DEVICE_NAME="$(adb devices | head -n2 | tail -n1 | awk '{print $1}')"
echo "--- The device name is $DEVICE_NAME"

OS_VERSION="$(adb -s $DEVICE_NAME shell getprop ro.build.version.release | tr -d '\r')"
echo "--- The device is running on the $OS_VERSION version of Android"

MAX_INSTANCES=1
echo "--- $MAX_INSTANCES instance(s) of the node will be used"

# DEVICE_UUID=$(ls -l /dev/disk/by-uuid/ | grep dm-1 | awk '{print $9}')
# echo "--- Caught $DEVICE_UUID as the UUID of the Android device"

echo "Connecting..."
docker run -it \
    --rm \
    -e CONNECT_TO_GRID=$CONNECT_TO_GRID \
    -e PLATFORM_NAME=$PLATFORM_NAME \
    -e APPIUM_HOST=$APPIUM_HOST \
    -e APPIUM_PORT=$APPIUM_PORT \
    -e SELENIUM_HOST=$SELENIUM_HOST \
    -e SELENIUM_PORT=$SELENIUM_PORT \
    -e BROWSER_NAME=$BROWSER_NAME \
    -e DEVICE_NAME=$DEVICE_NAME \
    -e OS_VERSION=$OS_VERSION \
    -e MAX_INSTANCES=$MAX_INSTANCES \
    gigouni/appium-1.6.5
    
echo "Closing Appium server"