#!/bin/bash
#### Description: Script to automatize the default run process
#### Author: Nicolas GIGOU <nicolas.gigou [at] gmail.com>

./build.sh

docker run \
    -it \
    --rm \
    -p 4444:4444 \
    --net=host \
    --name selenium-hub \
    gigouni/hub-3.4.0-dyprosium
    
echo "Closing Selenium hub"