#!/bin/bash
#### Description: Script to automatize the default run process
#### Author: Nicolas GIGOU <nicolas.gigou@telecomsante.com>

./build.sh

echo -e "\n\n"

docker run \
    -it \
    --rm \
    --link selenium-hub:hub \
    gigouni/chrome_stable
    
echo "Closing Chrome node"