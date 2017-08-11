#!/bin/bash
#### Description: Script to automatize the default build process
#### Author: Nicolas GIGOU <nicolas.gigou [at] gmail.com>

# ===============================================================
# DO NOT RUN DIRECTLY THIS SCRIPT, JUST RUN THE RUN.SH SCRIPT
# THE BUILD PHASE WILL BE AUTOMATICALLY DONE
# ===============================================================
docker build \
    --build-arg APPIUM_VERSION=1.6.5 \
    --build-arg CHROME_DRIVER_VERSION=2.23 \
    -t gigouni/appium-1.6.5 \
    .