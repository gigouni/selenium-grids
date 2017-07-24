# 1. Internet Explorer

<!-- TOC -->

- [1. Internet Explorer](#1-internet-explorer)
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
    - [1.5. Selenium Internet Explorer node](#15-selenium-internet-explorer-node)
    - [1.6. Tests](#16-tests)
        - [1.6.1. Settings](#161-settings)
        - [1.6.2. Run them all!](#162-run-them-all)

<!-- /TOC -->

Aim of this part: Run a Internet Explorer 11 node and connect it to a Selenium grid.
If you're interest by Edge, the content of this README is almost the same, except for the node configuration.

## 1.1. tl;dr

1. Create and switch on the Windows VM
2. Configure the VM
3. Run the hub
4. Run the Internet Explorer node
5. Configure the tests
6. Run the tests

## 1.2. Getting started

To plug a Internet Explorer node to a Selenium grid, we need to have a Windows environment due to mandatory dependencies. When you're actually working with it, it's not a problem but most of the developers community work with a Linux or Mac distribution. So we need to find alternatives to complete this part of the needs, no matter the host distribution.

For the next part, we're considering you're working on a Linux/Mac distribution. If you're using a Windows, you won't have to follow the first steps but _the configuration of the node may interest you_.

## 1.3. The virtual machine
### 1.3.1. Creation

When you need to work with Windows environment while being on a Linux (or Mac) one, you need to pass by virtual machines manager like VirtualBox (comes with a CLI tool, _VBOX Manage_). But, how to run VM without virtual environment? Microsoft provides it for you. These free VM are for development use. They are limited by their potential (dependencies, hardware settings, etc...) and by duration. You can only use each free VM for 90 days. But if you create a snapshot during the first days of the trial, you will be able to reset it regularly to a stable version.

To download it, you can [go to the microsoft website](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/) and choose your environment settings. Let's go for 

* Virtual machine: IE11 on Win81 (x86) __and__ IE11 on Win7 (x86)
* Select platform: VirtualBox

to get your ZIP file. Once you've installed it through the VirtualBox UI, you will be able to run it and configure it. Here, we've chosen two OS to assume the behavior of our application, no matter the version of Windows (as a kind of example).

### 1.3.2. Configuration
#### 1.3.2.1. Hardware

Before starting your machine, you can improve a little bit your experience by editing some default hardware settings. I recommend to increase the available __RAM to a minimum of 512Mb__ and to set the __memory cache to a minimum of 9Mb__ to be able to display the VM in a full-screen mode.

#### 1.3.2.2. Locale

If you're locale ain't the good one, go to _Settings_, 

* In _Date & Time_, change your timezone
* In _Region & language_, change your region and add your locale language (remove the default one)

After some seconds (time for locale to be downloaded and installed), your correct locale will be working like a charm.  

#### 1.3.2.3. Boot loading

You can prevent useless start services by taping _msconfig_ in the Windows search bar. In the _Start_ tab, disable services like OneDrive, useless in our case.

#### 1.3.2.4. Clipboard

Do not hesitate to share the clipboards between the host and the VM. To do it, with Virtual Box by example, you won't even need to shutdown your VM, just go 
to _Settings_, _General_, then _Advanced_. Set the _Shared clipboard_ value to _bidirectional_

#### 1.3.2.5. Security

Now, to run the scripts, you'll have two choices. The first is about copying/pasting the content of the scripts (and the binary files btw) in your VM is everything might be OK. But you can be decided to directly download these scripts. Being external, your VM won't know the source and by security measures, will block them. To bypass this situation, follow the next steps.

* Run Powershell as an Administrator
* Run this command and respond Yes (for all)

```shell
$ # Violent, but effective
$ Set-ExecutionPolicy Bypass
```

To understand why using _Bypass_ execution policy, follow [this technical note](https://4sysops.com/archives/powershell-bypass-executionpolicy-to-run-downloaded-scripts/).

### 1.3.3. Turning on

To be sure having all your previous configuration correctly set, you can reboot your VM and check everything. If you didn't do it yet, __I strongly recommend you to snapshot your current version of the VM__ to be sure having a backup in case of issues.

## 1.4. Selenium hub
### 1.4.1. Java dependencies

To run the Selenium hub, we will first need to fill the Java dependencies because we're using a JAR file. JAR files are Java archive, containing a set of functions and to access to them, we need to set our system to follow the good configuration. Don't worry, the scripts will do it for it. For this step, you just need to run the first script, _run_step_01_java.ps1_.

These scripts are Powershell ones to have a better bunch of scripting functions. Being sure that these scripts are for Windows environment make them perfectly suitable.

_Steps important in this script:_

* Check if Java is not already installed as a command
* If not, check if the JRE binary exists
* If true, install the JRE to have Java as a command

### 1.4.2. Run the hub

We will now use once again ready-to-run scripts. To help and improve your development process, you will find the second sprint, _run_step_02_hub.ps1_.

_Steps important in this script:_

* Check if Java is not already installed as a command
* If true, check if the JAR file exists
* If true, open the Internet Explorer browser to the hub IP address
* Run the JAR file to run the Selenium hub

## 1.5. Selenium Internet Explorer node

Finally, the third and last script, _run_step_03_node_ie11.ps1_, is to run the Internet Explorer node.

_Steps important in this script:_

* Check if Java is not already installed as a command
* If true, run the Internet Explorer node

## 1.6. Tests
### 1.6.1. Settings

The main aim of the Selenium grid is to be able to run tests on several platforms (browsers, operating systems). In that case, just as an example, I choose to test a website we all know, Google. The test is simple: on the Google homepage, waits until the page is fully loaded, searches the keyword 'google', then press "Search" button, clicks on the first link to return on the Google homepage.

As a test tool, I subjectively decided to use [MochaJS](https://mochajs.org/).

Now, we need to set the value of the constants to point to the Selenium grid. To achieve it, go in the _src/_ folder and check for the _constants.js_ file. The Google part is just for some indications and can be removed to be replaced by your own tests.

Each node has its own IP address but plugging to the hub is enough, the hub broadcasts the node call depending on the chosen capabilities.

### 1.6.2. Run them all!

In my case, I just need to run the tests by running this command in the _src/_ folder.

```shell
$ mocha --timeout 30000 tests.js
```

_Note:_

The timeout value here is necessary to avoid that your tests ask for the end before the real end of the tests. It this command crashes, increase the value. Depending on your test, you can try to decrease it but be careful. Even if you're running twice the same test in the exact same conditions, you're not sure having the same execution time.