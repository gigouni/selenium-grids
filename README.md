# 1. Selenium grids & Docker

A POC about the way of manipulate the Selenium grids for several platforms (Edge, Chrome or even Android, iOS, ...)

<!-- TOC -->

- [1. Selenium grids & Docker](#1-selenium-grids--docker)
    - [1.1. What it is?](#11-what-it-is)
    - [1.2. The objectives](#12-the-objectives)
    - [1.3. Authors](#13-authors)

<!-- /TOC -->

## 1.1. What it is?

[The Selenium grids](http://www.seleniumhq.org/projects/grid/) are tools to automatize tests on several OS and browsers. The grids are the hub of possible targets for the tests. For a better deployment process, Docker has been fully implemented and documented in sub-folders. [Docker](https://www.docker.com/) is a way to build light app within containers running on everywhere server or production system, independently of the host OS.

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

## 1.3. Authors

* [SeleniumHQ](https://github.com/SeleniumHQ/) - **initial work**
* [Nicolas GIGOU](https://github.com/gigouni/) - **implementation for Firefox, Chrome, Android, iOS, Safari, Edge, IE11**