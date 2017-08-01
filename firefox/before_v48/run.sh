#!/bin/bash
#### Description: Script to automatize the default run process
#### Author: Nicolas GIGOU <nicolas.gigou@telecomsante.com>

./build.sh

docker run \
    -it \
    --rm \
    --link selenium-hub:hub \
    gigouni/firefoxYOUR_VERSION
    
echo "Closing Firefox node"