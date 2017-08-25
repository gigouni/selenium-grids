# 1. Tests

A tests suite to assume the ways to interact with the Selenium grid.

<!-- TOC -->

- [1. Tests](#1-tests)
    - [1.1. Getting started](#11-getting-started)
        - [1.1.1. Basic tests run](#111-basic-tests-run)
        - [1.1.2. Complete tests run](#112-complete-tests-run)

<!-- /TOC -->

## 1.1. Getting started

### 1.1.1. Basic tests run

```shell
$ ./run_tests.sh
```

### 1.1.2. Complete tests run

```shell
$ ./run_tests.js 40000
```

_Note Bene:_

Here, the __40000__ value is the timeout for the tests. The default one, 2000 milliseconds, isn't enough. As an advice, avoid decrease below 40000 milliseconds.