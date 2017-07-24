# 1. Android device

<!-- TOC -->

- [1. Android device](#1-android-device)
    - [1.1. Prerequisites](#11-prerequisites)
    - [1.2. Getting started](#12-getting-started)
        - [1.2.1. Build](#121-build)
            - [1.2.1.1. Basic build](#1211-basic-build)
            - [1.2.1.2. Complete build](#1212-complete-build)
        - [1.2.2. Run](#122-run)
    - [1.3. Maintainability](#13-maintainability)
        - [1.3.1. Logs](#131-logs)
        - [1.3.2. SDK version](#132-sdk-version)
    - [Additional information](#additional-information)

<!-- /TOC -->

Aim of this part: Emulate Android devices within a Docker container.
This section is (mainly) coming form the [public repository of TheDrHax](https://github.com/TheDrHax/docker-android-avd/).
It has just been modified to correct some bugs and add compatibility with x86 devices.

## 1.1. Prerequisites

* KVM

The emulation of the Android device needs hardware acceleration so it has to have an enabled KVM (_Kernel Virtual Machine_). Within Docker itself, it's not possible but we can handle it in the host machine then pass it through the _docker run_ command.

On your host machine, run

```shell
$ sudo apt install cpu-checker && kvm-ok
```

If the result > 0, you can operate hardware acceleration. Just check if it exists before trying to pass it to Docker

```shell
$ ls /dev/kvm
```

You can load the KVM module with

```shell
$ modprobe kvm-intel
```

## 1.2. Getting started

You may already have the Dockerfile and the mandatory files if you're able to read this. You just need to run the _build_ step based on the Dockerfile. Then, go for the run of the generated image.

### 1.2.1. Build
#### 1.2.1.1. Basic build

```shell
$ docker build -t gigouni/android_device .
```

#### 1.2.1.2. Complete build

```shell
$ docker build \
    --build-arg _ABI=armeabi-v7a \
    --build-arg _TARGET=android-22 \
    --build-arg _NAME=Docker_AVD \
    --build-arg _EMULATOR=64-arm \
    -t gigouni/android_device \
    .
```

### 1.2.2. Run

```shell
$ docker run -it --rm --device /dev/kvm gigouni/android_device
```

_Note:_ The _--device /dev/kvm_ attribute is mandatory to pass the KVM from the host machine to the android device.

## 1.3. Maintainability
### 1.3.1. Logs

If you're encountering some troubles running or building your Docker image, the logs are available within the container in _/var/log/supervisor_

```shell
$ # Connect to the device container
$ docker exec -it $(docker ps | grep "gigouni/android_device" | head -n1 | awk '{print $1}') bash && ls -l /dev/disk/by-uuid | grep dm-1 | awk '{print $9}'
$
$ # Move to the logs folder
$ cd /var/log/supervisor
```

### 1.3.2. SDK version

This image is based one the [TheDrHax's SDK image](https://github.com/TheDrHax/docker-android-sdk/blob/master/Dockerfile). While writing these lines, it's running on the r25.2.5 but it can be updated [here](https://github.com/TheDrHax/docker-android-sdk/blob/master/Dockerfile#LC14) or even make it apart in another sub-module.

If you want to avoid the auto-update of the SDK version (and improve the build image process), remove it from [the Dockerfile](./Dockerfile) --> `$ANDROID_HOME/tools/bin/sdkmanager --update`.

## Additional information

To interact with the device and its inner configuration, you can connect to the container and play with ADB commands

Connection to the container of the device

```shell
$ docker exec -it $(docker ps | grep android_device | awk '{print $1}') bash
```

Get system basic information

```shell
$ adb device -l
$ # Should returns something like
$ # List of devices attached
$ # emulator-5554          
$ # device product:sdk_phone_x86_64 model:Android_SDK_built_for_x86_64 device:generic_x86_64
```

Get exhaustive configuration information

```shell
$ adb -s emulator-5554 shell getprop
$ # Should returns something like
$ # [ARGH]: [ARGH]
$ # [dalvik.vm.dex2oat-Xms]: [64m]
$ # [dalvik.vm.dex2oat-Xmx]: [512m]
$ # [dalvik.vm.heapsize]: [192m]
$ # etc...
```

Get specific configuration information (here _ro.runtime.firstboot_)

```shell
$ adb -s emulator-5554 shell getprop ro.runtime.firstboot 
1500626403550 
```