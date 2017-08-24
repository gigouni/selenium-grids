FROM selenium/node-base:3.4.0-dysprosium
LABEL first_authors=SeleniumHQ
LABEL last_author="Nicolas GIGOU <nicolas.gigou [at] gmail.com>"

USER seluser

#========================
# Selenium Configuration
#========================

ARG GRID_MAX_SESSION="5"
ARG GRID_NEW_SESSION_WAIT_TIMEOUT="-1"
ARG GRID_THROW_ON_CAPABILITY_NOT_PRESENT="true"
ARG GRID_JETTY_MAX_THREADS="-1"
ARG GRID_CLEAN_UP_CYCLE="5000"
ARG GRID_BROWSER_TIMEOUT="0"
ARG GRID_TIMEOUT="30"
ARG GRID_DEBUG="false"
ARG HUB_HOST="172.17.0.1"

ENV GRID_MAX_SESSION=${GRID_MAX_SESSION} \
    GRID_NEW_SESSION_WAIT_TIMEOUT=${GRID_NEW_SESSION_WAIT_TIMEOUT} \
    GRID_THROW_ON_CAPABILITY_NOT_PRESENT=${GRID_THROW_ON_CAPABILITY_NOT_PRESENT} \
    GRID_JETTY_MAX_THREADS=${GRID_JETTY_MAX_THREADS} \
    GRID_CLEAN_UP_CYCLE=${GRID_CLEAN_UP_CYCLE} \
    GRID_BROWSER_TIMEOUT=${GRID_BROWSER_TIMEOUT} \
    GRID_TIMEOUT=${GRID_TIMEOUT} \
    GRID_DEBUG=${GRID_DEBUG} \
    HUB_HOST=${HUB_HOST}

COPY generate_config \
    entry_point.sh \
    /opt/bin/

# Running this command as sudo just to avoid the message:
# To run a command as administrator (user "root"), use "sudo <command>". See "man sudo_root" for details.
RUN sudo /opt/bin/generate_config > /opt/selenium/config.json

CMD ["/opt/bin/entry_point.sh"]