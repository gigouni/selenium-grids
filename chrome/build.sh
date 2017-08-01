#!/bin/bash
#### Description: Script to automatize the default build process
#### Author: Nicolas GIGOU <nicolas.gigou@telecomsante.com>

# ===============================================================
# DO NOT RUN DIRECTLY THIS SCRIPT, JUST RUN THE RUN.SH SCRIPT
# THE BUILD PHASE WILL BE AUTOMATICALLY DONE
# ===============================================================
docker build \
    -t gigouni/chrome_stable \
    .