#!/bin/bash

NODE_CONFIG_JSON="/root/node_config.json"
CMD="xvfb-run appium"

if [ ! -z "$CONNECT_TO_GRID" ]; then
  /root/generate_config.sh
  CMD+=" --nodeconfig $NODE_CONFIG_JSON"
fi

$CMD