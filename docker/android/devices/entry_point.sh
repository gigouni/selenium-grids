#!/bin/bash

# =========================================================
# Get the installed emulator
#   head -n1: Caught the first and unique installed device
# =========================================================
DEVICE_NAME=$($ANDROID_HOME/tools/emulator -list-avds | head -n1)

# =================================================
# Run the selected device
#   -force-32bit: Mandatory to run 32 bits devices
# =================================================
$ANDROID_HOME/tools/emulator -avd $DEVICE_NAME -force-32bit