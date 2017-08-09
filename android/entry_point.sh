#!/bin/bash

CMD="xvfb-run appium"

if [ ! -z "$CONNECT_TO_GRID" ]; then
  /root/generate_config.sh


echo -e "\n==============================================================="
echo    "                         APPIUM SERVER                         "
echo    "==============================================================="
  CMD+=" --nodeconfig /root/node_config.json"
fi

$CMD