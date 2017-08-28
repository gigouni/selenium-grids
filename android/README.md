# 1. Appium server

<!-- TOC -->

- [1. Appium server](#1-appium-server)
    - [1.1. tl;dr](#11-tldr)
    - [1.2. Getting started](#12-getting-started)
        - [1.2.1. Conveniences](#121-conveniences)
        - [1.2.2. Build](#122-build)
        - [1.2.3. Run](#123-run)
            - [1.2.3.1. Device emulated with AVD](#1231-device-emulated-with-avd)
                - [1.2.3.1.1. Installation of Android Studio binaries](#12311-installation-of-android-studio-binaries)
                - [1.2.3.1.2. Create an AVD](#12312-create-an-avd)
                - [1.2.3.1.3. Run the AVD (and test its existence btw)](#12313-run-the-avd-and-test-its-existence-btw)
            - [1.2.3.2. Run without connection to the Selenium grid](#1232-run-without-connection-to-the-selenium-grid)
            - [1.2.3.3. Run with connection to the Selenium grid](#1233-run-with-connection-to-the-selenium-grid)
        - [1.2.4. Tests](#124-tests)
            - [1.2.4.1. Settings](#1241-settings)
            - [1.2.4.2. Run them all](#1242-run-them-all)

<!-- /TOC -->

Aim of this part: Run an Appium server within a Docker container, able to
connect to a Selenium grid using its IP address.

## 1.1. tl;dr

1. Run the hub
2. Run the device emulator
3. Run the Appium server
4. Configure the tests settings
5. Run the tests

```shell
$ # Hub
$ docker run \
    -it \
    --rm \
    -p 4444:4444 \
    --net=host \
    --name selenium-hub \
    gigouni/hub-3.4.0-dysprosium
$
$ # Download Android system images and create AVD
$ echo no | sdkmanager "system-images;android-24;google_apis;x86"
$ avdmanager create avd \
    -n gigouni_android_devices_API24 \
    -k "system-images;android-24;google_apis;x86" \
    -f
$
$ # Device emulator
$ $ANDROID_HOME/emulator/emulator -avd gigouni_android_devices_API24 [-gpu host]
$
$ # Run Appium server
$ ./run.sh
$
$ # Run tests (comment web sections)
$ ../src/tests.js
```

## 1.2. Getting started

You may already have the Dockerfile and the mandatory files if you're able to read this. You just need to run the _build_ step based on the Dockerfile. Then, go for the run of the generated image.

### 1.2.1. Conveniences

For convenience problems, think about the use of aliases or environment variables in your next commands. Here we'll add

```shell
$ # For sdkmanager and avdmanager usage
PATH=$PATH:$ANDROID_HOME/tools/bin/ ; export PATH
```

at the end of our ~/.bashrc to simplify the commands. In case you're not able to do it, just replace the commands by their absolute path.

### 1.2.2. Build

```shell
$ docker build \
    --build-arg APPIUM_VERSION=1.6.5 \
    --build-arg CHROME_DRIVER_VERSION=2.28 \
    -t gigouni/appium-1.6.5 \
    .
```

### 1.2.3. Run

To run correctly, the Appium server needs to be bind to (at least) one Android device. To do this, we need to create an AVD (_Android Virtual Device_) through the Android Studio command line interface or use a dockerize device.

#### 1.2.3.1. Device emulated with AVD

##### 1.2.3.1.1. Installation of Android Studio binaries

Before continuing, you'll need to have your $ANDROID_HOME set. This environment variable is bind to the android_studio path folder after its installation and permits to use the SDK Manager and the AVD Manager.

To install it through CLI, use the script below.

```shell
# Define the SDK and binaries version
SDK_VERSION=25.2.3
ANDROID_BUILD_TOOLS_VERSION=25.0.3
ANDROID_HOME="/opt/Android/Sdk"

# Download the ZIP archive, unpack it and provide rights
cd /opt
wget -O tools.zip https://dl.google.com/android/repository/tools_r${SDK_VERSION}-linux.zip
unzip tools.zip && rm tools.zip
chmod a+x -R ${ANDROID_HOME}
chown -R root:root ${ANDROID_HOME}

# Update to the latest stable version
echo y | android update sdk -a -u -t platform-tools,build-tools-${ANDROID_BUILD_TOOLS_VERSION}

# Update PATH environment variable
PATH=${PATH}:${ANDROID_HOME}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/build-tools
export PATH
```

##### 1.2.3.1.2. Create an AVD

Here, creating an API 24 Android device. These operations can be quite long so don't be surprised for not having an instant response. Once done, you'll receive a _done_ output.

```shell
$ echo no | sdkmanager "system-images;android-24;google_apis;x86"
$ avdmanager create avd \
    -n gigouni_android_devices_API24 \
    -k "system-images;android-24;google_apis;x86" \
    -f
```

or for a more generic form (choose your target and your ABI (_Application Binary Interface_))

```shell
$ echo no | sdkmanager "system-images;${TARGET};${IMG_TYPE};${ABI}"
$ echo no | avdmanager create avd \
    -n "gigouni_android_devices_API${TARGET}" \
    -k "system-images;${TARGET};${IMG_TYPE};${ABI}" \
    -f
```

To assume the list of correct API versions, check [this out](https://developer.android.com/about/dashboards/index.html).
For the documentation about ABIs, [check this out](https://developer.android.com/ndk/guides/abis.html).

You might be confronted to a problem while trying to update your SDK with previous Android version like

```shell
Filter sys-img-${your-abi}-${your-target} not supported
```

To assume the exact list of supported filters, use this command ([source](https://stackoverflow.com/questions/42460205/truncated-android-sdk-package-paths-from-sdkmanager-cli)).

```shell
$ sdkmanager \
    --list \
    --verbose | grep -vP "^Info:|^\s|^$|^done$"
```

You can also have a warning like

```shell
Warning: File /home/gigouni/.android/repositories.cfg could not be loaded.
```

It's totally skippable but if it's annoying you, create it.

```shell
touch /home/gigouni/.android/repositories.cfg
```

More info [here](https://askubuntu.com/questions/885658/android-sdk-repositories-cfg-could-not-be-loaded).

##### 1.2.3.1.3. Run the AVD (and test its existence btw)

One you've created AVDs, you are able to consult the exhaustive list of them all.

```shell
$ avdmanager list avd
```

If you want to check the existence of a specific AVD, you can use

```shell
$ # Generic form
$ avdmanager list avd | grep <avd-name>

$ # Example
$ avdmanager list avd | grep gigouni_android_devices_API24
```

You shall be seeing something like

```shell
$ avdmanager list avd | grep gigouni_android_devices_API24
    Name: gigouni_android_devices_API24
    Path: /home/gigouni/.android/avd/gigouni_android_devices_API24.avd
```

If not, return to the _Create an AVD step_. If it's good, let's run the emulator (from $ANDROID_HOME/tools/emulator).

```shell
# Generic form
$ emulator -avd <avd-name>
$ # or
$ emulator @<avd-name>
$
$ # Example
$ emulator -avd gigouni_android_devices_API24
```

After the end of the boot of the device, run

```shell
$ adb devices
```

to be sure that your device is working well. You should see something like

```shell
$ List of devices attached
emulator-5554 device
```

__Possible issues:__

- Qt library not found

```shell
[139659433264960]:ERROR:./android/qt/qt_setup.cpp:28:Qt library not found at ../emulator/lib64/qt/lib
Could not launch '../emulator/qemu/linux-x86_64/qemu-system-i386': No such file or directory
```

It's a [known error](https://issuetracker.google.com/issues/37137213), even if it's not a real one. Just avoid using your emulator from $ANDROID_HOME/tools/emulator but use $ANDROID_HOME/emulator/emulator instead.

As a workaround, use [this solution](https://stackoverflow.com/questions/42554337/cannot-launch-avd-in-emulatorqt-library-not-found#answer-42955322).

- Cannot run the emulator for these settings

Not the exact message but you've got it. If you're getting it, you've got a problem during the configuration of your device. The ABI and/or the target might not be matching a suitable combination. Edit it following the documentation links and repeat the previous operations.

- Emulator showing black screen and 'adb devices' shows device as offline

It seems to be due to the incompatibilities between the Host GPU and the emulated one. It's a [known issue](https://stackoverflow.com/questions/10022580/android-emulator-shows-nothing-except-black-screen-and-adb-devices-shows-device) and it can be handled by checking the [Android documentation here](https://developer.android.com/studio/run/emulator-acceleration.html). To sum up, you need to run your device with another parameter.

```shell
$ emulator -avd gigouni_android_devices_API24 -gpu host
```

#### 1.2.3.2. Run without connection to the Selenium grid

```shell
$ docker run -it \
    --rm \
    gigouni/appium-1.6.5
```

#### 1.2.3.3. Run with connection to the Selenium grid

```shell
$ docker run -it \
    --rm \
    -e CONNECT_TO_GRID=true \
    -e PLATFORM_NAME=Android \
    -e APPIUM_HOST=0.0.0.0 \
    -e APPIUM_PORT=4723 \
    -e SELENIUM_HOST=172.17.0.1 \
    -e SELENIUM_PORT=4444 \
    -e BROWSER_NAME=Chrome \
    -e DEVICE_NAME=emulator-5554 \
    -e OS_VERSION=4.1.2 \
    -e MAX_INSTANCES=1 \
    gigouni/appium-1.6.5
```

To get another correct example, please refer to the [./run.sh script](./run.sh) in this folder.

To get the IP address of your Selenium hub, run an instance of the hub
image and use the next command

```shell
$ docker inspect $(docker ps | grep "selenium/hub" | awk '{print $1}') | grep "\"IPAddress\"" | head -n1 | awk '{print $2}' | tr -d \" | tr -d \,
```

- _docker ps | grep "selenium/hub" | awk '{print $1}'_ -> Get container ID
- _docker inspect_ -> Get properties of the container
- _head -n1_ -> Get the first line of IPAddress (it's given twice)
- _awk '{print $2}'_ -> Only catch the IP address without the label
- _tr -d \" | tr -d \,_ -> Remove the boring special characters

_Note:_ If this command returns _""docker inspect" requires at least 1 argument(s)."_,
you may haven't run the Selenium hub yet.

### 1.2.4. Tests

#### 1.2.4.1. Settings

The main aim of the Selenium grid is to be able to run tests on several platforms (browsers, operating systems). In that case, just as an example, I choose to test a website we all know, Google. The test is simple: on the Google homepage, waits until the page is fully loaded, searches the keyword 'google', then press "Search" button, clicks on the first link to return on the Google homepage.

As a test tool, I subjectively decided to use [MochaJS](https://mochajs.org/).

Now, we need to set the value of the constants to point to the Selenium grid. To achieve it, go in the _src/_ folder and check for the _constants.js_ file. The Google part is just for some indications and can be removed to be replaced by your own tests.

Each node has its own IP address but plugging to the hub is enough, the hub broadcasts the node call depending on the chosen capabilities.

#### 1.2.4.2. Run them all

In my case, I just need to run the tests by running this command in the _src/_ folder.

```shell
$ ../src/run_tests.sh
```

_Note:_

The timeout value here is necessary to avoid that your tests ask for the end before the real end of the tests. It this command crashes, increase the value. Depending on your test, you can try to decrease it but be careful. Even if you're running twice the same test in the exact same conditions, you're not sure having the same execution time.

__Possible issues:__

- An unknown server-side error occurred while processing the command. Original error: unknown error: Chrome version must be >= xx.y.z

This error is something know and due to ChromeDriver compatibility. When running your device, check its Chrome version (_Run Chrome/Settings/About Chrome/Application version_). Either your get an updated version of Chrome either you choose another version of ChromeDriver when building your Docker image. Just follow [this link](https://github.com/appium/appium/blob/master/docs/en/advanced-concepts/chromedriver.md) to know which version corresponding to yours. Or you can refer to these lines

--> ["Supports Chrome" lines](https://chromedriver.storage.googleapis.com/2.30/notes.txt)

- ChromeDriver v2.30 : Supports Chrome v58-60
- ChromeDriver v2.29 : Supports Chrome v56-58
- ChromeDriver v2.28 : Supports Chrome v55-57
- ChromeDriver v2.27 : Supports Chrome v54-56
- ChromeDriver v2.26 : Supports Chrome v53-55
- ChromeDriver v2.25 : Supports Chrome v53-55
- ChromeDriver v2.24 : Supports Chrome v52-54