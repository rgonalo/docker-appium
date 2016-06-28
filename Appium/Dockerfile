FROM ubuntu:20.04
MAINTAINER Ruben Gonzalez Alonso <rgonalo@gmail.com>

#===============================
# Customize sources for apt-get
#===============================
RUN echo "deb http://archive.ubuntu.com/ubuntu focal main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu focal-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu focal-security main universe\n" >> /etc/apt/sources.list

#===================================================================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#===================================================================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    ca-certificates \
    openjdk-8-jdk-headless \
    wget \
    unzip \
  && rm -rf /var/lib/apt/lists/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

#=============
# Android SDK
#=============
ENV ANDROID_BUILD_TOOLS_VERSION 29.0.3
# Get Android SDK version from https://developer.android.com/studio/index.html#command-tools
ENV ANDROID_SDK_VERSION 6609375
ENV ANDROID_SDK_ROOT /opt/android-sdk
ENV PATH ${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/emulator:${ANDROID_SDK_ROOT}/tools:${ANDROID_SDK_ROOT}/platform-tools
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools \
  && cd $ANDROID_SDK_ROOT/cmdline-tools \
  && wget --no-verbose http://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip -O android-tools.zip \
  && unzip android-tools.zip \
  && rm -f android-tools.zip \
  && mv tools latest
RUN echo y | sdkmanager "platform-tools"
RUN echo y | sdkmanager "build-tools;$ANDROID_BUILD_TOOLS_VERSION"

#===================
# Nodejs and Appium
#===================
ENV APPIUM_VERSION 1.18.2
# ENV NODE_VERSION 10.19.0 (latest version in Ubuntu 20.04)
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    nodejs \
    npm \
  && npm install -g appium@$APPIUM_VERSION --unsafe-perm=true \
  && npm cache clean --force \
  && apt-get remove --purge -y npm \
  && apt-get autoremove --purge -y \
  && rm -rf /var/lib/apt/lists/*

#============================================
# Add udev rules file with USB configuration
#============================================
ENV UDEV_REMOTE_FILE https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
RUN mkdir -p /etc/udev/rules.d \
  && wget --no-verbose $UDEV_REMOTE_FILE -O /etc/udev/rules.d/51-android.rules

# Appium server port
EXPOSE 4723

CMD appium
