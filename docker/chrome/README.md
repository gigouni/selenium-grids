# Chrome & docker

A Dockerfile to dockerify any version in {stable, unstable, beta} of Google Chrome and push it within a Selenium grid for automatication tests

<!-- TOC -->

- [Chrome & docker](#chrome--docker)
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
$ cd selenium-grids/chrome
```

Build a Docker image following your necessary version(s)

```shell
$ sudo docker build -t test/chrome .
```

Run your Selenium hub (_if it's not already running_)

```shell
$ udo docker run -it --rm -p 4444:4444 --name selenium-hub selenium/hub:3.4.0-dysprosium
```

Run your new Firefox image

```shell
$ sudo docker run -it --rm --link selenium-hubb:hub test/chrome
```

Check if it's working [here](http://localhost:4444/grid/console). Enjoy!

## Authors

* [SeleniumHQ](https://github.com/SeleniumHQ/) - **initial work**
* [Nicolas GIGOU](https://github.com/gigouni/) - **implementation for Firefox, Chrome, Android, iOS, Safari, Edge, IE11**