# 1. Chrome

A Dockerfile to dockerize any version in {stable, unstable, beta} of Google Chrome and push it within a Selenium grid for automation tests.

<!-- TOC -->

- [1. Chrome](#1-chrome)
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
$ docker build -t gigouni/chrome_stable .
$ docker run \
    -it \
    --rm \
    -p 4444:4444 \
    --net=host \
    --name selenium-hub \
    gigouni/hub-3.4.0-dysprosium
$ docker run \
    -it \
    -e HUB_PORT_4444_TCP_ADDR=172.17.0.1 \
    -e HUB_PORT_4444_TCP_PORT=4444 \
    -e NODE_PORT=5557 \
    gigouni/chrome_stable
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
    -t gigouni/chrome_stable .
```

### 1.2.2. Run

Run your Selenium hub (_if it's not already running_)

```shell
$ docker run \
    -it \
    --rm \
    -p 4444:4444 \
    --net=host \
    --name selenium-hub \
    gigouni/hub-3.4.0-dysprosium
```

#### 1.2.2.1. Basic run

Run your new Chrome image

```shell
$ docker run \
    -it \
    -e HUB_PORT_4444_TCP_ADDR=172.17.0.1 \
    -e HUB_PORT_4444_TCP_PORT=4444 \
    -e NODE_PORT=5557 \
    gigouni/chrome_stable
```

#### 1.2.2.2. Complete run

```shell
$ docker run \
    -it \
    -e HUB_PORT_4444_TCP_ADDR=172.17.0.1 \
    -e HUB_PORT_4444_TCP_PORT=4444 \
    -e NODE_PORT=5557 \
    -e CHROME_VERSION=google-chrome-stable \
    -e CHROME_DRIVER_VERSION=2.30 \
    -e NODE_MAX_INSTANCES=1 \
    -e NODE_APPLICATION_NAME=node-chrome \
    -e NODE_MAX_SESSION=1 \
    -e NODE_REGISTER_CYCLE=5000 \
    -e NODE_POLLING=5000 \
    -e NODE_UNREGISTER_IF_STILL_DOWN_AFTER=60000 \
    -e NODE_DOWN_POLLING_LIMIT=2 \
    gigouni/chrome_stable
```

Check if it's working [here](http://localhost:4444/grid/console)