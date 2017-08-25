#!/bin/bash
#### Description: Script to automatize the run of the Android device
#### Author: Nicolas GIGOU <nicolas.gigou [at] gmail.com>

echo "Emulator starting..."
$ANDROID_HOME/emulator/emulator @gigouni_android_devices_API25
echo "Emulator shutdown"