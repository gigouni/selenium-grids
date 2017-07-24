#!/bin/bash

CMD="xvfb-run appium"

if [ ! -z "$CONNECT_TO_GRID" ]; then
  /root/generate_config.sh
  CMD+=" --nodeconfig /root/node_config.json"
fi

$CMD