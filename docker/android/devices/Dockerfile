FROM thedrhax/android-sdk
LABEL maintainer "Nicolas Gigou <nicolas.gigou@telecomsante.com>"

#=================================
# To be able to create the device
#=================================
USER root

#===============================
# ADB and terminal ports of AVD
#===============================
EXPOSE 5554 5555

#=================================================================================
# Install Qt Widgets to be able to emulate the device while running the container
#=================================================================================
RUN apt-get update \
 && apt-get install -y libqt5widgets5 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists /var/cache/apt

#=======================
# Make it customizable
#=======================
ARG _NAME="Docker_AVD"
ARG _ABI="x86_64"
ARG _TARGET="android-24"

ENV NAME=$_NAME \
    ABI=$_ABI \
    TARGET=$_TARGET

#===================
# Create AVD device
#===================
RUN echo y | $ANDROID_HOME/tools/android update sdk --filter ${TARGET} --no-ui --force -a
RUN echo y | $ANDROID_HOME/tools/android update sdk --filter sys-img-${ABI}-${TARGET} --no-ui --force -a
RUN echo no | $ANDROID_HOME/tools/android create avd --name ${NAME} --abi ${ABI} --target ${TARGET}
RUN mkdir -p $ANDROID_HOME/tools/keymaps
RUN touch $ANDROID_HOME/tools/keymaps/fr-fr

#============================
# Script to run the emulator
#============================
COPY entry_point.sh /root/
RUN chmod +x /root/entry_point.sh

#==============
# Run emulator
#==============
CMD ["/root/entry_point.sh"]