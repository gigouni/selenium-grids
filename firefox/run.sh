#!/bin/bash
#### Description: Script to automatize the default run process
#### Author: Nicolas GIGOU <nicolas.gigou [at] gmail.com>

./build.sh

docker run \
    -it \
    --rm \
    -e HUB_PORT_4444_TCP_ADDR=172.17.0.1 \
    -e HUB_PORT_4444_TCP_PORT=4444 \
    -e NODE_PORT=5558 \
    gigouni/firefox53
    
echo "Closing Firefox node"