# 1. Selenium grids

A POC about the way of manipulate the Selenium grids for several platforms (Edge, Chrome or even Android, iOS, ...)

<!-- TOC -->

- [1. Selenium grids](#1-selenium-grids)
    - [1.1. What it is?](#11-what-it-is)
    - [1.2. The objectives](#12-the-objectives)
    - [1.3. How to proceed (_the Docker version_)](#13-how-to-proceed-_the-docker-version_)

<!-- /TOC -->

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

## 1.3. How to proceed (_the Docker version_)

You can have [the details here](./docker/README.md) or just follow the next commands

```shell
$ # SELENIUM HUB
$ sudo docker run -it --rm -p 4444:4444 --name selenium-hub selenium/hub:3.4.0-dysprosium
$ 
$ # CHROME NODE
$ # Works with the stable, beta, unstable versions
$ git clone https://github.com/gigouni/selenium-grids && cd selenium-grids/docker
$ sudo docker build -t test/chrome .
$ sudo docker run -it --rm --link my-selenium-hub:hub test/chrome
$ 
$ # FIREFOX NODE
$ # Works with the desired versions
$ sudo docker build --build-arg FIREFOX_VERSION=MY_VERSION -t test/firefoxMY_VERSION .
$ sudo docker run -it --rm --link my-selenium-hub:hub test/firefoxMY_VERSION
```