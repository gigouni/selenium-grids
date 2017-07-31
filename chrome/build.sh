#!/bin/bash
#### Description: Script to automatize the default build process
#### Author: Nicolas GIGOU <nicolas.gigou@telecomsante.com>

docker build \
    -t gigouni/chrome_stable \
    .