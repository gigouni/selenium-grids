#!/bin/bash
#### Description: Script to automatize the default run process
#### Author: Nicolas GIGOU <nicolas.gigou [at] gmail.com>

./build.sh

CONNECT_TO_GRID=true
PLATFORM="ANDROID"
PLATFORM_NAME="Android"
APPIUM_HOST=0.0.0.0
APPIUM_PORT=4723
SELENIUM_HOST="localhost"
SELENIUM_PORT=4444
BROWSER_NAME="Chrome"
DEVICE_NAME="emulator-5554"
OS_VERSION="7.1.1"
MAX_INSTANCES=1

# To be able to run the image with the rights to edit network interfaces: --cap-add=NET_ADMIN
docker run -it \
    --rm \
    -e CONNECT_TO_GRID=$CONNECT_TO_GRID \
    -e PLATFORM=$PLATFORM \
    -e PLATFORM_NAME=$PLATFORM_NAME \
    -e APPIUM_HOST=$APPIUM_HOST \
    -e APPIUM_PORT=$APPIUM_PORT \
    -e SELENIUM_HOST=$SELENIUM_HOST \
    -e SELENIUM_PORT=$SELENIUM_PORT \
    -e BROWSER_NAME=$BROWSER_NAME \
    -e DEVICE_NAME=$DEVICE_NAME \
    -e OS_VERSION=$OS_VERSION \
    -e MAX_INSTANCES=$MAX_INSTANCES \
    --net=host \
    gigouni/appium-1.6.5
    
info "Closing Appium server"