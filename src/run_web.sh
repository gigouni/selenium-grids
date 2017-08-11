#!/bin/bash
#### Description: Script to automatize the default run process
#### Author: Nicolas GIGOU <nicolas.gigou [at] gmail.com>

if [[ $1 ]]; then
    TIMEOUT=$1
else
    # Default value
    TIMEOUT=30000
fi

echo "Starting the tests..."
echo "Timeout value: $TIMEOUT"

mocha --timeout $TIMEOUT tests_web.js

echo "Closing the tests"