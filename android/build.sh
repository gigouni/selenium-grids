#!/bin/bash
#### Description: Script to automatize the default build process
#### Author: Nicolas GIGOU <nicolas.gigou@telecomsante.com>

docker build \
    --build-arg APPIUM_VERSION=1.6.5 \
    -t gigouni/appium-1.6.5 \
    .