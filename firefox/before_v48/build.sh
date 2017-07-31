#!/bin/bash
#### Description: Script to automatize the default build process
#### Author: Nicolas GIGOU <nicolas.gigou@telecomsante.com>

docker build \
    build --build-arg FIREFOX_VERSION=YOUR_VERSION \
    -t gigouni/firefoxYOUR_VERSION \
    .