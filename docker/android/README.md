# 1. Appium server

<!-- TOC -->

- [1. Appium server](#1-appium-server)
    - [1.1. Getting started](#11-getting-started)
        - [1.1.1. Build](#111-build)
            - [1.1.1.1. Basic build](#1111-basic-build)
            - [1.1.1.2. Complete build](#1112-complete-build)
        - [1.1.2. Run](#112-run)
            - [1.1.2.1. Run without connection to the Selenium grid](#1121-run-without-connection-to-the-selenium-grid)
            - [1.1.2.2. Run with connection to the Selenium grid](#1122-run-with-connection-to-the-selenium-grid)

<!-- /TOC -->

Aim of this part: Run an Appium server within a Docker container, able to
connect to a Selenium grid using its IP address.

## 1.1. Getting started

You may already have the Dockerfile and the mandatory files if you're able to read this. You just need to run the _build_ step based on the Dockerfile. Then, go for the run of the generated image.

### 1.1.1. Build
#### 1.1.1.1. Basic build

```shell
$ docker build -t ts_selenium/appium-1.6.5 .
```

#### 1.1.1.2. Complete build

```shell
$ docker build \
    --build-arg SDK_VERSION=25.2.3 \
    --build-arg ANDROID_BUILD_TOOLS_VERSION=25.0.3 \
    --build-arg APPIUM_VERSION=1.6.5 \
    -t ts_selenium/appium-1.6.5 \
    .
```

### 1.1.2. Run
#### 1.1.2.1. Run without connection to the Selenium grid

```shell
$ docker run -it \
    --rm \
    ts_selenium/appium-1.6.5
```

#### 1.1.2.2. Run with connection to the Selenium grid

```shell
$ docker run -it \
    --rm \
    -e CONNECT_TO_GRID=true \
    -e PLATFORM_NAME=Android \
    -e APPIUM_HOST=127.0.0.1 \
    -e APPIUM_PORT=4723 \
    -e SELENIUM_HOST=172.17.0.2 \
    -e SELENIUM_PORT=4444 \
    -e BROWSER_NAME=android \
    -e UDID=254789fc-0410-4b35-9108-12ed647bbad4 \
    ts_selenium/appium-1.6.5
```

To get the IP address of your Selenium hub, run an instance of the Selenium
image and use the next command

```shell
$ # docker ps | grep "selenium/hub" | awk '{print $1}' -> Get container ID
$ # docker inspect -> Get properties of the container
$ # head -n1 -> Get the first line of IPAddress (it's given twice)
$ # awk '{print $2}' -> Only catch the IP address without the label
$ # tr -d \" | tr -d \, -> Remove the boring special characters
$ docker inspect $(docker ps | grep "selenium/hub" | awk '{print $1}') | grep "\"IPAddress\"" | head -n1 | awk '{print $2}' | tr -d \" | tr -d \,
```

_Note:_ If this command returns _""docker inspect" requires at least 1 argument(s)."_,
you may haven't run the Selenium hub yet.