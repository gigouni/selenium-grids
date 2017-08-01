#!/bin/bash
#### Description: Script to automatize the default run process
#### Author: Nicolas GIGOU <nicolas.gigou@telecomsante.com>

./build.sh

docker run \
    -it \
    --rm \
    --link selenium-hub:hub \
    gigouni/firefox53
    
echo "Closing Firefox node"