#!/bin/bash
#### Description: Script to automatize the default build process
#### Author: Nicolas GIGOU <nicolas.gigou [at] gmail.com>

## For Chrome driver version, check this
# https://chromedriver.storage.googleapis.com/2.30/notes.txt, "Supports Chrome" lines
# ChromeDriver v2.30 : Supports Chrome v58-60
# ChromeDriver v2.29 : Supports Chrome v56-58
# ChromeDriver v2.28 : Supports Chrome v55-57
# ChromeDriver v2.27 : Supports Chrome v54-56
# ChromeDriver v2.26 : Supports Chrome v53-55
# ChromeDriver v2.25 : Supports Chrome v53-55
# ChromeDriver v2.24 : Supports Chrome v52-54

# ===============================================================
# DO NOT RUN DIRECTLY THIS SCRIPT, JUST RUN THE RUN.SH SCRIPT
# THE BUILD PHASE WILL BE AUTOMATICALLY DONE
# ===============================================================
docker build \
    --build-arg APPIUM_VERSION=1.6.5 \
    --build-arg CHROME_DRIVER_VERSION=2.28 \
    -t gigouni/appium-1.6.5 \
    .