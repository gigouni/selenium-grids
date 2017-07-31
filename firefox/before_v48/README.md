# 1. Firefox before 48

Aim of this part: explain the problematic coming from building Docker images for Firefox before its 48 version.

<!-- TOC -->

- [1. Firefox before 48](#1-firefox-before-48)
    - [1.1. tl;dr](#11-tldr)
    - [1.2. Explanations](#12-explanations)
    - [1.3. Getting started](#13-getting-started)
        - [1.3.1. Build](#131-build)
            - [1.3.1.1. Basic build](#1311-basic-build)
            - [1.3.1.2. Complete build](#1312-complete-build)
        - [1.3.2. Run](#132-run)
            - [1.3.2.1. Basic run](#1321-basic-run)
            - [1.3.2.2. Complete run](#1322-complete-run)

<!-- /TOC -->

## 1.1. tl;dr

To run everything in a single terminal, use _detached mode_, with the _-d_ argument.

```shell
$ docker build --build-arg FIREFOX_VERSION=YOUR_VERSION -t gigouni/firefoxYOUR_VERSION .
$ docker run -it -d --rm -p 4444:4444 --name selenium-hub selenium/hub:3.4.0-dysprosium
$ docker run -it -d --rm --link selenium-hub:hub gigouni/firefoxYOUR_VERSION
```

_Note:_

Here, YOUR_VERSION needs to be before 48. It won't work either.

## 1.2. Explanations

When building Docker images of Firefox with recent versions (>48), it uses GeckoDriver. It wasn't true before this version. It was using the Marionette driver.

For most of the following content, it's the same as the parent README (Firefox) one but adapted for older versions of Firefox (<48) to fit with Marionette.

## 1.3. Getting started

### 1.3.1. Build

You can build Docker images of Firefox using the version you need [from the list here](https://ftp.mozilla.org/pub/firefox/releases/).

#### 1.3.1.1. Basic build

```shell
$ docker build -t gigouni/firefoxYOUR_VERSION .
```

#### 1.3.1.2. Complete build

Build a Docker image following your needed version

```shell
$ docker build --build-arg FIREFOX_VERSION=YOUR_VERSION -t gigouni/firefoxYOUR_VERSION .
```

### 1.3.2. Run

Run your Selenium hub (_if it's not already running_)

```shell
$ docker run -it --rm -p 4444:4444 --name selenium-hub selenium/hub:3.4.0-dysprosium
```

#### 1.3.2.1. Basic run

Run your new Firefox image

```shell
$ docker run -it --rm --link my-selenium-hub:hub gigouni/firefoxYOUR_VERSION
```

#### 1.3.2.2. Complete run

```shell
$ docker run -it \
    --rm \
    -e NODE_MAX_INSTANCES=1 \
    -e NODE_MAX_SESSION=1 \
    -e NODE_REGISTER_CYCLE=5000 \
    -e NODE_PORT=5556 \
    --link selenium-hub:hub \
    gigouni/firefoxYOUR_VERSION
```

Check if it's working [here](http://localhost:4444/grid/console). 
Enjoy!

_Note:_

* The usage of the _link_ argument is deprecated. You shall think about edit it ASAP.
* Here, _NODE_ stands for the Selenium _node_, not NodeJS.