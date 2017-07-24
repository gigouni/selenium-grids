# 1. Edge

<!-- TOC -->

- [1. Edge](#1-edge)
    - [1.1. tl;dr](#11-tldr)
    - [1.2. Getting started](#12-getting-started)
    - [1.3. The virtual machine](#13-the-virtual-machine)
        - [1.3.1. Creation](#131-creation)
        - [1.3.2. Configuration](#132-configuration)
            - [1.3.2.1. Hardware](#1321-hardware)
            - [1.3.2.2. Locale](#1322-locale)
            - [1.3.2.3. Boot loading](#1323-boot-loading)
            - [1.3.2.4. Clipboard](#1324-clipboard)
            - [1.3.2.5. Security](#1325-security)
        - [1.3.3. Turning on](#133-turning-on)
    - [1.4. Selenium hub](#14-selenium-hub)
        - [1.4.1. Java dependencies](#141-java-dependencies)
        - [1.4.2. Run the hub](#142-run-the-hub)
    - [1.5. Selenium Edge node](#15-selenium-edge-node)
    - [1.6. Tests](#16-tests)
        - [1.6.1. Settings](#161-settings)
        - [1.6.2. Run them all!](#162-run-them-all)

<!-- /TOC -->

Aim of this part: Run a Edge node and connect it to a Selenium grid.
If you're interest by Internet Explorer, the content of this README is almost the same, except for the node configuration.

## 1.1. tl;dr

1. Create and switch on the Windows VM
2. Configure the VM
3. Run the hub
4. Run the Edge node
5. Configure the tests
6. Run the tests

## 1.2. Getting started

To plug a Edge node to a Selenium grid, we need to have a Windows environment due to mandatory dependencies. When you're actually working with it, it's not a problem but most of the developers community work with a Linux or Mac distribution. So we need to find alternatives to complete this part of the needs, no matter the host distribution.

For the next part, we're considering you're working on a Linux/Mac distribution. If you're using a Windows, you won't have to follow the first steps but _the configuration of the node may interest you_.

## 1.3. The virtual machine
### 1.3.1. Creation

When you need to work with Windows environment while being on a Linux (or Mac) one, you need to pass by virtual machines manager like VirtualBox. But, how to run VM without virtual environment? Microsoft provides it for you. These free VM are for development use. They are limited by their potential (dependencies, hardware settings, etc...) and by duration. You can only use each free VM for 90 days. But if you create a snapshot during the first days of the trial, you will be able to reset it regularly to a stable version.

To download it, you can [go to the microsoft website](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/) and choose your environment settings. Let's go for 

* Virtual machine: Microsoft Edge on Win10 (x64) Stable (15.15063)
* Select platform: VirtualBox

to get your ZIP file. Once you've installed it through the VirtualBox UI, you will be able to run it and configure it. 

### 1.3.2. Configuration
#### 1.3.2.1. Hardware

Before starting your machine, you can improve a little bit your experience by editing some default hardware settings. I recommand to increase the available __RAM to a minimum of 512Mb__ and to set the __memory cache to a minimum of 9Mb__ to be able to display the VM in a fullscreen mode.

#### 1.3.2.2. Locale

If you're locale ain't the good one, go to _Settings_, 

* In _Date & Time_, change your timezone
* In _Region & language_, change your region and add your locale langage (remove the default one)

After some seconds (time for locale to be downloaded and installed), your correct locale will be working like a charm.  

#### 1.3.2.3. Boot loading

You can prevent useless start services by taping _msconfig_ in the Windows search bar. In the _Start_ tab, disable services like OneDrive, useless in our case.

#### 1.3.2.4. Clipboard

Do not hesitate to share the clipboards between the host and the VM. To do it, with Virtual Box by exemple, you won't even need to shutdown your VM, just go 
to _Settings_, _General_, then _Advanced_. Set the _Shared clipboard_ value to _bidirectional_

#### 1.3.2.5. Security

Now, to run the scripts, you'll have two choices. The first is about copying/pasting the content of the script (and the binary files btw) in your VM is everything might be OK. But you can be decided to directly download these scripts. Being external scripts, your VM won't know the source and by security measures, will block the script. To bypass this situation, follow the next steps.

* Run Powershell as an Administrator
* Run this command and respond Yes (for all)

```shell
$ # Violent, but effective
$ Set-ExecutionPolicy Bypass
```

To understand why using _Bypass_ execution policy, follow [this technical note](https://4sysops.com/archives/powershell-bypass-executionpolicy-to-run-downloaded-scripts/).

### 1.3.3. Turning on
## 1.4. Selenium hub
### 1.4.1. Java dependencies
### 1.4.2. Run the hub
## 1.5. Selenium Edge node
## 1.6. Tests
### 1.6.1. Settings
### 1.6.2. Run them all!