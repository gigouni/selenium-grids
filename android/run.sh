#!/bin/bash
#### Description: Script to automatize the default run process
#### Author: Nicolas GIGOU <nicolas.gigou@telecomsante.com>

info () { echo -e "[INFO]    $1"; }
debug () { echo -e "[DEBUG]   $1"; }
error () { echo -e "[ERROR]   $1"; }
stop () {
    info "Script stopped"
    exit 1
}

./build.sh

echo -e "\n\n"

# ============================================================
# Connection to the grid
# ============================================================
CONNECT_TO_GRID=true
info "Connection to the grid starting..."

# ============================================================
# Platform of the device
# ============================================================
PLATFORM_NAME="Android"
info "--- Adding a node for an $PLATFORM_NAME device"

# ============================================================
# Appium address
# ============================================================
# The APPIUM here refers to the Android device connection
APPIUM_HOST=10.0.2.2
APPIUM_PORT=4723
info "--- Caught $APPIUM_HOST:$APPIUM_PORT as the Appium IP address"

# ============================================================
# Selenium hub
# ============================================================
# Check if the Selenium hub is running
# Everything will fail if it's not running correctly right here
if [[ $(docker ps | grep "selenium/hub" | wc -l) -eq 0 ]]; then
    error "The Selenium hub isn't running... I'm a good boy, I'll run it for you"
    docker run -it -d --rm -p 4444:4444 --name selenium-hub selenium/hub:3.4.0-dysprosium
    # Check if the instance is now running
    if [[ $(docker ps | grep "selenium/hub" | wc -l) -ne 0 ]]; then
        info "The Selenium is now running successfully!\n"
    else
        error "You might have a problem with your internet connection or network, the script isn't able to download the Selenium Docker image"
        error "Check it before running again this script"
        stop
    fi
fi

SELENIUM_HOST=$(docker inspect $(docker ps | grep "selenium/hub" | awk '{print $1}') | grep "\"IPAddress\"" | head -n1 | awk '{print $2}' | tr -d \" | tr -d \,)
SELENIUM_PORT=4444
info "--- Caught $SELENIUM_HOST:$SELENIUM_PORT as the Selenium IP address"

# ============================================================
# Target browser
# ============================================================
BROWSER_NAME="android"
info "--- The tests will run on the $BROWSER_NAME browser"

# ============================================================
# Android device capture
# ============================================================
# DEVICE_NAME="notevenarealname"
DEVICE_NAMES="$(adb devices | head -n -1 | sed -n '1!p' | awk '{print $1}')"
NB_DEVICE_RUNNING="$(adb devices | head -n -1 | sed -n '1!p' | wc -l)"
if [[ ! $DEVICE_NAMES ]]
then
    error "Your device (starting with 'emulator-') isn't running. Script stopped" && exit 1
elif [[ $NB_DEVICE_RUNNING -eq 1 ]]
then
    debug "Only one device is running"
    DEVICE_NAME="$(adb devices | head -n2 | tail -n1 | awk '{print $1}')"
    debug "Emulator detected. Name: $DEVICE_NAME"
else
    debug "Several devices are running. Here the list of the detected devices: \n\n$DEVICE_NAMES\n"
    # Loop over names to avoid conflicts while having several devices running
    while IFS= read -r device 
    do
        if [[ $device == emulator* ]]; then
            DEVICE_NAME=$device
            debug "Emulator detected. Name in the while loop: $DEVICE_NAME"
            break
        fi
    done < <(echo "$DEVICE_NAMES")
fi
info "--- The device name is $DEVICE_NAME"

OS_VERSION="$(adb -s $DEVICE_NAME shell getprop ro.build.version.release | tr -d '\r')"
info "--- The device is running on the $OS_VERSION version of Android"

# ============================================================
# Number of node running instances
# ============================================================
MAX_INSTANCES=1
info "--- $MAX_INSTANCES instance(s) of the node will be used"

# ============================================================
# Connection
# ============================================================
info "Connecting..."

# To be able to run the image with the rights to edit network interfaces: --cap-add=NET_ADMIN
docker run -it \
    --rm \
    --cap-add=NET_ADMIN \
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
    
info "Closing Appium server"