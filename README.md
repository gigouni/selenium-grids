# 1. Selenium grids

A POC about the way of manipulate the Selenium grids for several platforms (Edge, Chrome or even Android, iOS, ...)

- [1. Selenium grids](#1-selenium-grids)
    - [1.1. What it is?](#11-what-it-is)
    - [1.2. The objectives](#12-the-objectives)
    - [1.3. How to proceed (_the simplified version_)](#13-how-to-proceed-_the-simplified-version_)
    - [1.4. Step by step](#14-step-by-step) - _In progress_
    - [1.5. References](#15-references)

## 1.1. What it is?

[The Selenium grids](http://www.seleniumhq.org/projects/grid/) are tools to automatize tests on several OS and browsers. The grids are the hub of possible targets for the tests.

## 1.2. The objectives

When you don't know something, your objectives can be related to questions

* How implement the Selenium grids?
* How use Microsoft's virtual machines to emulate Microsoft's product environment?
* How produce tests on Android emulator through Appium and how use the grid related to it?
* How use the grids with iOS?
* How much resources does it consume?
* How much computers/machines are necessary to run it?

The support should be resolved for

* Google Chrome
* Mozilla Firefox
* Microsoft Edge
* Internet Explorer 11
* Android
* iOS

## 1.3. How to proceed (_the simplified version_)

* Download the Selenium server standalone
* Prepare a file to test some properties of a website for __Chrome__ through the Chrome driver
* Prepare a file to test some properties of a website for __Firefox__ through the Gecko driver
* Prepare an almost empty android app to use Appium (Android inspection)
* Prepare an almost empty iOS app and check how to proceed
* Run the Selenium JAR
* Run the sample apps and the test files

## 1.4. Step by step

* [Download here](http://www.seleniumhq.org/download/) the latest version of the standalone server of Selenium or use the command

```shell
$ curl -O http://selenium-release.storage.googleapis.com/3.4/selenium-server-standalone-3.4.0.jar
```
* Run the Selenium JAR

```shell
$ java -jar ~/Downloads/selenium-server-standalone-3.4.0.jar -port 4444 -role hub
```

If it's displaying _'INFO - Selenium Grid hub is up and running'_, your server starts successfully

Run the tests with Mocha (timeout to let the script works. Increase it if you're computer is slow & need more time)

```shell
$ # Run the Selenium hub 172.17.0.1:4444
$ java -jar bin/selenium-server.jar -role hub -host 172.17.0.1 -port 4444
$
$ # Run the Firefox node 172.17.0.1:5555 and connect it to the Selenium hub
$ java -jar bin/selenium-server.jar -role node -hub http://172.17.0.1:4444/grid/register -browser browserName=firefox  -port 5555
$
$ # Run the Chrome node 172.17.0.1:5557 and connect it to the Selenium hub
$ java -Dwebdriver.chrome.driver=bin/drivers/chromedriver -jar bin/selenium-server.jar -role webdriver -hub  http://172.17.0.1:4444/grid/register -browser browserName=chrome,platform=LINUX -port 5557
$
$ # Run the Edge node 172.17.0.1:5558 and connect it to the Selenium hub
$ java -Dwebdriver.edge.driver=bin/drivers/MicrosoftWebDriver.exe -jar bin/selenium-server.jar -role webdriver -hub http://172.17.0.1:4444/grid/register -browser browserName=edge,platform=LINUX -port 5558
$
$ # Run the web tests for the previous browsers
$ mocha --timeout 30000 src/web/tests.js
```

## Change logs

Check the [CHANGELOG.md](./CHANGELOG.md)

## 1.5. References

* [Selenium grid for Appium mobile automation](http://www.vimalselvam.com/2016/05/15/selenium-grid-for-appium-mobile-automation/)
* [Running selenium functional tests in webdriver.io against selenium grid setup guide](https://medium.com/@dbillinghamuk/running-selenium-functional-tests-in-webdriver-io-against-selenium-grid-setup-guide-aabbfda9c05d)
* [Selenium grid for RC and WebDriver](https://github.com/SeleniumHQ/selenium/wiki/Grid2)
* [Class Driver](http://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/ie_exports_Driver.html#wait)