# 1. Selenium grids & Docker

A POC about the way of manipulate the Selenium grids for several platforms (Edge, Chrome or even Android, iOS, ...)

<!-- TOC -->

- [1. Selenium grids & Docker](#1-selenium-grids--docker)
    - [1.1. What it is?](#11-what-it-is)
    - [1.2. Explanations](#12-explanations)

<!-- /TOC -->

## 1.1. What it is?

[Docker](https://www.docker.com/) is a way to build light app within containers running on everywhere server or production system, independently of the host OS.

Run it this way avoid almost all integrations problems and is a time-earner.

```shell
$ # SELENIUM HUB
$ docker run -it --rm -p 4444:4444 --name my-selenium-hub selenium/hub:3.4.0-dysprosium
$ 
$ # CHROME NODE
$ # Works with the stable, beta, unstable versions
$ git clone https://github.com/gigouni/selenium-grids && cd selenium-grids/docker
$ cd chrome && sudo docker build -t test/chrome .
$ docker run -it --rm --link my-selenium-hub:hub test/chrome
$ 
$ # FIREFOX NODE
$ # Works with the desired versions
$ $ cd firefox && sudo docker build --build-arg FIREFOX_VERSION=MY_VERSION -t test/firefoxMY_VERSION .
$ docker run -it --rm --link my-selenium-hub:hub test/firefoxMY_VERSION
```

## 1.2. Explanations

* __sudo__: Avoid issues like the most popular one '_Cannot connect to the Docker daemon. Is the docker daemon running on this host?_'. But you should add your $USER to the Docker group instead
* __docker__: Yep, it's easier to use Docker while calling the docker command
* __run__: Run an existing, local or remote, Docker image
* __-it__: Bind the output with your terminal
* __--rm__: Remove cleanly the container when shutting down the container
* __-p 4444:4444__: The port(s) to expose with the format HOST_PORT:CONTAINER_PORT
* __--name selenium/hub__: Make it easier to distinguish/find the current image in your Docker images list
* __selenium/hub:3.4.0-dysprosium__: The Docker image to run
* __build__: Build a Docker image following the Dockerfile instructions
* __-t__: Add a name/tag to distinguish this image
* __--link__: Bind with another node/hub using its name
* __--build-arg FIREFOX_VERSION=MY_VERSION__: Edit the environment variables value