FROM ubuntu:16.04

LABEL author "Srinivasan Sekar <srinivasan.sekar1990@gmail.com>"
LABEL editor "Nicolas Gigou <nicolas.gigou [at] gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

#=============
# Set WORKDIR
#=============
WORKDIR /root

#==================
# General Packages
#------------------
# openjdk-8-jdk
#   Java
# ca-certificates
#   SSL client
# tzdata
#   Timezone
# unzip
#   Unzip zip file
# curl
#   Transfer data from or to a server
# wget
#   Network downloader
# libqt5webkit5
#   Web content engine (Fix issue in Android)
# libgconf-2-4
#   Required package for chrome and chromedriver to run on Linux
# xvfb
#   X virtual framebuffer
#==================
RUN apt-get -qqy update && \
    apt-get -qqy --no-install-recommends install \
    openjdk-8-jdk \
    ca-certificates \
    tzdata \
    unzip \
    curl \
    wget \
    libqt5webkit5 \
    libgconf-2-4 \
    xvfb \
    python python-dev python-pip python-virtualenv \
  && rm -rf /var/lib/apt/lists/*

#===============
# Set JAVA_HOME
#===============
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre"
ENV PATH="$PATH:$JAVA_HOME/bin"

#=====================
# Install Android SDK
#=====================
ARG SDK_VERSION=25.2.3
ARG ANDROID_BUILD_TOOLS_VERSION=25.0.3
ENV SDK_VERSION=${SDK_VERSION} \
    ANDROID_BUILD_TOOLS_VERSION=${ANDROID_BUILD_TOOLS_VERSION} \
    ANDROID_HOME="/root"

RUN wget -O tools.zip https://dl.google.com/android/repository/tools_r${SDK_VERSION}-linux.zip && \
    unzip tools.zip && rm tools.zip && \
    chmod a+x -R ${ANDROID_HOME} && \
    chown -R root:root ${ANDROID_HOME}

ENV PATH=${PATH}:${ANDROID_HOME}/tools

RUN echo y | android update sdk -a -u -t platform-tools,build-tools-${ANDROID_BUILD_TOOLS_VERSION}

ENV PATH=${PATH}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/build-tools

#====================================
# Install latest nodejs, npm, appium
#====================================
ARG APPIUM_VERSION=1.6.5
ARG CHROME_DRIVER_VERSION=2.28

ENV APPIUM_VERSION=${APPIUM_VERSION} \
    CHROME_DRIVER_VERSION=${CHROME_DRIVER_VERSION}

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get -qqy install nodejs && \
    echo Y | apt install build-essential && \
    npm install -g gulp appium-gulp-plugins && \
    npm install -g appium-doctor && \
    appium-doctor && \
    npm install -g appium@${APPIUM_VERSION} --chromedriver_version="$CHROME_DRIVER_VERSION" --no-shrinkwrap --unsafe-perm && \
    npm cache clean --force && \
    apt-get remove --purge -y npm && \
    apt-get autoremove --purge -y && \
    apt-get clean

#==================================
# Fix Issue with timezone mismatch
#==================================
ENV TZ="US/Pacific"
RUN echo "${TZ}" > /etc/timezone

#===============
# Expose Ports
#---------------
# 4723
#   Appium port
#===============
EXPOSE 4723

#====================================================
# Scripts to run appium and connect to Selenium Grid
#====================================================
COPY \
  entry_point.sh \
  generate_config.sh \
    /root/
RUN chmod +x /root/entry_point.sh && \
    chmod +x /root/generate_config.sh

#========================================
# Run appium server
#========================================
CMD ["/root/entry_point.sh"]