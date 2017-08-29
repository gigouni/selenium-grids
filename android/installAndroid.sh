#!/bin/bash
#### Description: Script to install Android Studio and set ANDROID_HOME environment variable.
#### Author: Nicolas GIGOU <nicolas.gigou [at] gmail.com>

# -----------------------------------------
# Settings
# -----------------------------------------
echo "Set the variables values..."
SDK_VERSION=25.2.3 ; echo "SDK_VERSION: $SDK_VERSION"
ANDROID_BUILD_TOOLS_VERSION=25.0.3 ; echo "ANDROID_BUILD_TOOLS_VERSION: $ANDROID_BUILD_TOOLS_VERSION"
LIB_FOLDER="/home/indi/lib" ; echo "LIB_FOLDER: $LIB_FOLDER"
ANDROID_HOME="/home/indi/lib/Android/Sdk" ; echo "ANDROID_HOME: $ANDROID_HOME"
echo "Variables set"


# -----------------------------------------
# Commands
# -----------------------------------------
echo "Check existing commands..."

# UNZIP
command -v unzip >/dev/null 2>&1 || {
        echo >&2 "Unzip command not installed. The script will try to resolve it.";
        sudo apt-get install unzip;
}
command -v unzip >/dev/null 2>&1 || {
        echo >&2 "Unzip command still not installed. It's a unresolvable issue here. Aborting.";
        exit 1;
}
echo "Unzip installed"

# WGET
command -v wget >/dev/null 2>&1 || {
        echo >&2 "wget command not installed. The script will try to resolve it.";
        sudo apt-get install wget;
}
command -v wget >/dev/null 2>&1 || {
        echo >&2 "wget command still not installed. It's a unresolvable issue here. Aborting.";
        exit 1;
}
echo "wget installed"


# -----------------------------------------
# Install
# -----------------------------------------
echo "Move to the installation folder..."
cd $LIB_FOLDER

# Java
echo y | sudo apt-get install default-jre

# Download the ZIP archive, unpack it and provide rights
echo "Download the ZIP file..."
wget -O tools.zip https://dl.google.com/android/repository/tools_r${SDK_VERSION}-linux.zip
echo "Unpack the ZIP file..."
unzip tools.zip && rm tools.zip
mkdir -p $ANDROID_HOME && mv ./tools/ $ANDROID_HOME
echo "Change rights and ownership..."
chmod a+x -R ${ANDROID_HOME}
chown -R root:root ${ANDROID_HOME}

# Update to the latest stable version
echo "Update Android..."
echo y | $ANDROID_HOME/tools/android update sdk -a -u -t platform-tools,build-tools-${ANDROID_BUILD_TOOLS_VERSION}

# Update PATH environment variable
echo "Previous PATH value: $PATH"
PATH=${PATH}:${ANDROID_HOME}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/build-tools
export PATH
echo "New PATH value: $PATH"

# -----------------------------------------
# Check
# -----------------------------------------
command -v android >/dev/null 2>&1 || {
        echo >&2 "android command not installed. Aborting.";
        exit 1;
}