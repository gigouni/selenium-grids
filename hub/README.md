# 1. Hub

A Dockerfile to dockerize a hub to set up a Selenium grid for automation tests.

<!-- TOC -->

- [1. Hub](#1-hub)
    - [1.1. tl;dr](#11-tldr)
    - [1.2. Getting started](#12-getting-started)
        - [1.2.1. Build](#121-build)
        - [1.2.2. Run](#122-run)

<!-- /TOC -->

## 1.1. tl;dr

To run everything in a single terminal, use _detached mode_, with the _-d_ argument.
```shell
$ docker build -t gigouni/hub-3.4.0-dysprosium .
$ docker run \
    -it \
    --rm \
    -p 4444:4444 \
    --net=host \
    --name selenium-hub \
    gigouni/hub-3.4.0-dysprosium
```

## 1.2. Getting started

### 1.2.1. Build

```shell
$ docker build -t gigouni/hub-3.4.0-dysprosium .
```

### 1.2.2. Run

Run your Selenium hub

```shell
$ docker run \
    -it \
    --rm \
    -p 4444:4444 \
    --net=host \
    --name selenium-hub \
    gigouni/hub-3.4.0-dysprosium
```

Check if it's working [here](http://localhost:4444/grid/console)