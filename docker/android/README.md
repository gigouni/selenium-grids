# 1. Appium server

<!-- TOC -->

- [1. Appium server](#1-appium-server)
    - [1.1. Getting started](#11-getting-started)
        - [1.1.1. Conveniences](#111-conveniences)
        - [1.1.2. Build](#112-build)
            - [1.1.2.1. Basic build](#1121-basic-build)
            - [1.1.2.2. Complete build](#1122-complete-build)
        - [1.1.3. Run](#113-run)
            - [1.1.3.1. With AVD](#1131-with-avd)
                - [1.1.3.1.1. Create an AVD](#11311-create-an-avd)
                - [1.1.3.1.2. [TODO] Run the AVD to test it](#11312-todo-run-the-avd-to-test-it)
            - [1.1.3.2. With Docker](#1132-with-docker)
            - [1.1.3.3. Run without connection to the Selenium grid](#1133-run-without-connection-to-the-selenium-grid)
            - [1.1.3.4. Run with connection to the Selenium grid](#1134-run-with-connection-to-the-selenium-grid)

<!-- /TOC -->

Aim of this part: Run an Appium server within a Docker container, able to
connect to a Selenium grid using its IP address.

## 1.1. Getting started

You may already have the Dockerfile and the mandatory files if you're able to read this. You just need to run the _build_ step based on the Dockerfile. Then, go for the run of the generated image.

### 1.1.1. Conveniences

For convenience problems, think about the use of aliases or environment variables in your next commands. Here we'll add 

```shell
$ # For sdkmanager and avdmanager usage
PATH=$PATH:$ANDROID_HOME/tools/bin/ ; export PATH
```

at the end of our ~/.bashrc to simplify the commands. In case you're not able to do it, just replace the commands by their absolute path.

### 1.1.2. Build
#### 1.1.2.1. Basic build

```shell
$ docker build -t ts_selenium/appium-1.6.5 .
```

#### 1.1.2.2. Complete build

```shell
$ docker build \
    --build-arg SDK_VERSION=25.2.3 \
    --build-arg ANDROID_BUILD_TOOLS_VERSION=25.0.3 \
    --build-arg APPIUM_VERSION=1.6.5 \
    -t ts_selenium/appium-1.6.5 \
    .
```

### 1.1.3. Run

To run correctly, the Appium server needs to be binded to (at least) one Android device. To do this, we need to create an AVD (_Android Virtual Device_) through the Android Studio command line interface or use a dockerize device.

#### 1.1.3.1. With AVD

##### 1.1.3.1.1. Create an AVD

Here, creating an API 24 Android device. The 'echo no' is to avoid human interaction with the question "Do you wish to create a custom hardware profile? [no]".

```shell
$ echo y | $ANDROID_HOME/tools/bin/sdkmanager update sdk \
    --filter android-24 --no-ui -a
$ echo y | $ANDROID_HOME/tools/bin/sdkmanager update sdk \
    --filter sys-img-x86_64-android-24 --no-ui -a
$ echo no | $ANDROID_HOME/tools/bin/avdmanager create avd \
    -n ts_selenium_android_devices_API24 \
    -k "system-images;android-24;google_apis_playstore;x86"
```

or for a more generic form (choose your target and your ABI (_Application Binary Interface_))

```shell
$ echo y | $ANDROID_HOME/tools/bin/sdkmanager update sdk \
    --filter ${TARGET} --no-ui -a
$ echo y | $ANDROID_HOME/tools/bin/sdkmanager update sdk \
    --filter sys-img-${ABI}-${TARGET} --no-ui -a
$ echo no | $ANDROID_HOME/tools/bin/avdmanager create avd \
    -n ts_selenium_android_devices_API24 \
    -k "system-images;${TARGET};google_apis_playstore;${ABI}"
```

To assume the list of correct API versions, check [this out](https://developer.android.com/about/dashboards/index.html).

##### 1.1.3.1.2. [TODO] Run the AVD to test it

/--> **Content to add ASAP** <--/

#### 1.1.3.2. With Docker 

Check [this README](./devices/README.md).

#### 1.1.3.3. Run without connection to the Selenium grid

```shell
$ docker run -it \
    --rm \
    ts_selenium/appium-1.6.5
```

#### 1.1.3.4. Run with connection to the Selenium grid

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