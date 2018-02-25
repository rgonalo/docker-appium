FROM ubuntu:16.04
MAINTAINER Ruben Gonzalez Alonso <rgonalo@gmail.com>

#===============================
# Customize sources for apt-get
#===============================
RUN echo "deb http://archive.ubuntu.com/ubuntu xenial main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu xenial-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu xenial-security main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://deb.nodesource.com/node_6.x xenial main\n" >> /etc/apt/sources.list

#===================================================================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#===================================================================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    ca-certificates \
    openjdk-8-jdk-headless \
    wget \
  && rm -rf /var/lib/apt/lists/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

#=============
# Android SDK
#=============
ENV ANDROID_SDK_VERSION 24.4.1
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
RUN cd /opt \
  && wget --no-verbose http://dl.google.com/android/android-sdk_r$ANDROID_SDK_VERSION-linux.tgz -O android-sdk.tgz \
  && tar xzf android-sdk.tgz \
  && rm -f android-sdk.tgz \
  && cd android-sdk-linux/tools \
  && mv -f emulator64-arm emulator \
  && rm -f emulator64* emulator-* \
  && chmod +x android emulator

#=====================
# Android SDK Manager
#=====================
ENV ANDROID_COMPONENTS platform-tools,build-tools-25.0.3
RUN echo y | android update sdk --all --force --no-ui --filter ${ANDROID_COMPONENTS}

#===================
# Nodejs and Appium
#===================
ENV APPIUM_VERSION 1.7.2
RUN  wget --no-verbose http://deb.nodesource.com/gpgkey/nodesource.gpg.key -O - | apt-key add - \
  && apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    nodejs \
  && npm install -g appium@$APPIUM_VERSION \
  && npm cache clean \
  && apt-get remove --purge -y npm \
  && apt-get autoremove --purge -y \
  && rm -rf /var/lib/apt/lists/*

#============================================
# Add udev rules file with USB configuration
#============================================
ENV UDEV_REMOTE_FILE https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
RUN mkdir /etc/udev/rules.d \
  && wget --no-verbose $UDEV_REMOTE_FILE -O /etc/udev/rules.d/51-android.rules

# Appium server port
EXPOSE 4723

CMD appium
