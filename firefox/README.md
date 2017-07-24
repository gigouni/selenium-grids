# Firefox & docker

A Dockerfile to dockerify any version of Mozilla Firefox and push it within a Selenium grid for automatication tests

<!-- TOC -->

- [Firefox & docker](#firefox--docker)
    - [Getting started](#getting-started)
    - [Authors](#authors)

<!-- /TOC -->

## Getting started

Clone the stack

```shell
$ git clone https://github.com/gigouni/selenium-grids
```

Move to the good folder

```shell
$ cd selenium-grids/firefox
```

Build a Docker image following your necessary version(s)

```shell
$ sudo docker build --build-arg FIREFOX_VERSION=YOUR_VERSION -t test/firefoxYOUR_VERSION .
```

Run your Selenium hub (_if it's not already running_)

```shell
$ sudo docker run -it --rm -p 4444:4444 --name selenium-hub selenium/hub:3.4.0-dysprosium
```

Run your new Firefox image (_WARNING: when choosing your Firefox version, please prefer [48+ due to compatibility support](https://github.com/mozilla/geckodriver/issues/85)_)

```shell
$ sudo docker run -it --rm --link my-selenium-hub:hub test/firefoxYOUR_VERSION
```

Check if it's working [here](http://localhost:4444/grid/console). Enjoy!

## Authors

* [SeleniumHQ](https://github.com/SeleniumHQ/) - **initial work**
* [Nicolas GIGOU](https://github.com/gigouni/) - **implementation for Firefox, Chrome, Android, iOS, Safari, Edge, IE11**