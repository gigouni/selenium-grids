# 1. Firefox

A Dockerfile to dockerize any version of Mozilla Firefox and push it within a Selenium grid for automation tests.

<!-- TOC -->

- [1. Firefox](#1-firefox)
    - [1.1. tl;dr](#11-tldr)
    - [1.2. Getting started](#12-getting-started)
        - [1.2.1. Build](#121-build)
            - [1.2.1.1. Basic build](#1211-basic-build)
            - [1.2.1.2. Complete build](#1212-complete-build)
            - [1.2.1.3. Example with Firefox 52.2.1-ESR](#1213-example-with-firefox-5221-esr)
        - [1.2.2. Run](#122-run)
            - [1.2.2.1. Basic run](#1221-basic-run)
            - [1.2.2.2. Complete run](#1222-complete-run)

<!-- /TOC -->

## 1.1. tl;dr

To run everything in a single terminal, use _detached mode_, with the _-d_ argument.
```shell
$ docker build --build-arg FIREFOX_VERSION=YOUR_VERSION -t gigouni/firefoxYOUR_VERSION .
$ docker run -it -d --rm -p 4444:4444 --name selenium-hub selenium/hub:3.4.0-dysprosium
$ docker run -it -d --rm --link selenium-hub:hub gigouni/firefoxYOUR_VERSION
```

## 1.2. Getting started
### 1.2.1. Build

You can build Docker images of Firefox using the version you need [from the list here](https://ftp.mozilla.org/pub/firefox/releases/).

#### 1.2.1.1. Basic build

```shell
$ docker build -t gigouni/firefoxYOUR_VERSION .
```

#### 1.2.1.2. Complete build

Build a Docker image following your needed version

```shell
$ docker build --build-arg FIREFOX_VERSION=YOUR_VERSION -t gigouni/firefoxYOUR_VERSION .
```

#### 1.2.1.3. Example with Firefox 52.2.1-ESR

```shell
$ # Build the Firefox 52.2.1-ESR Docker image
$ docker build \
    --build-arg FIREFOX_VERSION=52.2.1esr \
    -t gigouni/firefox52.2.1-esr \
    .

$ # Run the gigouni/firefox52.2.1-esr image
$ docker run \
    -it \
    --rm \
    --link my-selenium-hub:hub \
    gigouni/firefox52.2.1-esr
```

__For FF < 48__

_Geckodriver_, the Mozilla Firefox driver, is suitable [since the 48.0](https://github.com/mozilla/geckodriver/issues/85). Before this version, you need to pass by [Marionette](https://developer.mozilla.org/fr/docs/Mozilla/QA/Marionette). If you're using Selenium > 3.0, Marionette is already include within the JAR file. To build images for FF < 48, please refer to [this folder instead](./before_v48/Dockerfile).

### 1.2.2. Run

Run your Selenium hub (_if it's not already running_)

```shell
$ docker run -it --rm -p 4444:4444 --name selenium-hub selenium/hub:3.4.0-dysprosium
```

#### 1.2.2.1. Basic run

Run your new Firefox image

```shell
$ docker run -it --rm --link my-selenium-hub:hub gigouni/firefoxYOUR_VERSION
```

#### 1.2.2.2. Complete run

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