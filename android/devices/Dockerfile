FROM thedrhax/android-sdk:latest

# x86 emulation requires hardware acceleration
# that requires access to /dev/kvm (--device /dev/kvm)
# that requires running as root
USER root

# ADB and terminal ports of AVD
EXPOSE 5554 5555

RUN apt-get update \
 && apt-get install -y libqt5widgets5 socat supervisor \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists /var/cache/apt

# Supported ABIs: https://developer.android.com/ndk/guides/abis.html
# Android API 22: Lollipop, ABI x86
# Android API 23: Marshmallow, ABI x86_64
ARG _ABI="x86_64"
ARG _TARGET="android-23"
ARG _NAME="mavd"
ARG _EMULATOR="64-x86"

ENV ABI=${_ABI} \
    TARGET=${_TARGET} \
    NAME=${_NAME} \
    EMULATOR=${_EMULATOR}

RUN echo y | $ANDROID_HOME/tools/android update sdk --filter ${TARGET} --no-ui --force -a \
 && echo y | $ANDROID_HOME/tools/android update sdk --filter sys-img-${ABI}-${TARGET} --no-ui --force -a \
 && android list target \
 && echo no | $ANDROID_HOME/tools/android create avd -t ${TARGET} -n ${NAME} --abi ${ABI} \
 && mkdir -p $ANDROID_HOME/tools/keymaps \
 && touch $ANDROID_HOME/tools/keymaps/en-us \
 && $ANDROID_HOME/tools/bin/sdkmanager --update

RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY socat.sh /usr/local/bin/socat.sh

CMD /usr/bin/supervisord