# 1. Chrome & docker

A Dockerfile to dockerize any version in {stable, unstable, beta} of Google Chrome and push it within a Selenium grid for automatication tests

<!-- TOC -->

- [1. Chrome & docker](#1-chrome--docker)
    - [1.1. tl;dr](#11-tldr)
    - [1.2. Getting started](#12-getting-started)
        - [1.2.1. Build](#121-build)
            - [1.2.1.1. Basic build](#1211-basic-build)
            - [1.2.1.2. Complete build](#1212-complete-build)
        - [1.2.2. Run](#122-run)
            - [1.2.2.1. Basic run](#1221-basic-run)
            - [1.2.2.2. Complete run](#1222-complete-run)

<!-- /TOC -->

## 1.1. tl;dr

To run everything in a single terminal, use _detached mode_, with the _-d_ argument.
```shell
$ docker build -t gigouni/chrome .
$ docker run -it -d --rm -p 4444:4444 --name selenium-hub selenium/hub:3.4.0-dysprosium
$ docker run -it -d --rm --link selenium-hub:hub gigouni/chrome
```

## 1.2. Getting started
### 1.2.1. Build
#### 1.2.1.1. Basic build

Build a Docker image following your necessary version(s)

```shell
$ docker build -t gigouni/chrome .
```

#### 1.2.1.2. Complete build

```shell
$ docker build \
    --build-arg CHROME_VERSION=stable \
    --build-arg CHROME_DRIVER_VERSION=2.30 \
    -t gigouni/chrome .
```

### 1.2.2. Run

Run your Selenium hub (_if it's not already running_)

```shell
$ docker run -it --rm -p 4444:4444 --name selenium-hub selenium/hub:3.4.0-dysprosium
```

#### 1.2.2.1. Basic run

Run your new Chrome image

```shell
$ docker run -it --rm --link selenium-hub:hub gigouni/chrome
```

#### 1.2.2.2. Complete run

```shell
$ docker run -it \
    --rm \
    -e NODE_MAX_INSTANCES=1 \
    -e NODE_MAX_SESSION=1 \
    -e NODE_REGISTER_CYCLE=5000 \
    -e NODE_PORT=5555 \
    --link selenium-hub:hub \
    gigouni/chrome
```

Check if it's working [here](http://localhost:4444/grid/console). Enjoy!

_Note:_

* The usage of the _link_ argument is deprecated. You shall think about edit it ASAP.
* Here, _NODE_ stands for the Selenium _node_, not NodeJS.