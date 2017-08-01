#!/bin/bash
#### Description: Script to automatize the default run process
#### Author: Nicolas GIGOU <nicolas.gigou@telecomsante.com>

./build.sh

echo -e "\n\n"

CONNECT_TO_GRID=true
echo "Connection to the grid starting..."

PLATFORM_NAME="Android"
echo "--- Adding a node for an $PLATFORM_NAME device"

# The APPIUM here refers to the Android device connection
APPIUM_HOST=10.0.2.15
APPIUM_PORT=5555
echo "--- Caught $APPIUM_HOST:$APPIUM_PORT as the Appium IP address"

# Check if the Selenium hub is running
# Everything will fail if it's not running correctly right here
if [[ $(docker ps | grep "selenium/hub" | wc -l) -eq 0 ]]; then
    echo -e "\n--------- ERROR ---------"
    echo "The Selenium hub isn't running"
    echo "I'm a good boy, I'll run it for you"
    docker run -it -d --rm -p 4444:4444 --name selenium-hub selenium/hub:3.4.0-dysprosium
    if [[ $(docker ps | grep "selenium/hub" | wc -l) -ne 0 ]]; then
        echo -e "\n--------- INFO ---------"
        echo -e "The Selenium is now running successfully!\n"
    else
        echo -e "\n--------- ERROR ---------"
        echo "You might have a problem with your internet connection or network, the script isn't not able to download the Selenium Docker image"
        echo "Check it before running again this script"
        echo -e "Script stopped\n"
        exit 1
    fi
fi

SELENIUM_HOST=$(docker inspect $(docker ps | grep "selenium/hub" | awk '{print $1}') | grep "\"IPAddress\"" | head -n1 | awk '{print $2}' | tr -d \" | tr -d \,)
SELENIUM_PORT=4444
echo "--- Caught $SELENIUM_HOST:$SELENIUM_PORT as the Selenium IP address"

BROWSER_NAME="android"
echo "--- The tests will run on the $BROWSER_NAME browser"

DEVICE_NAME="$(adb devices | head -n2 | tail -n1 | awk '{print $1}')"
if [[ ! $DEVICE_NAME ]]; then
    echo -e "\n--------- ERROR ---------"
    echo "Your device isn't running"
    echo "Script stopped"
    exit 1
fi
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