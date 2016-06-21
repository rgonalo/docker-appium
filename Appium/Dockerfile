FROM ubuntu:16.04
MAINTAINER Ruben Gonzalez Alonso <rgonalo@gmail.com>

#===============================
# Customize sources for apt-get
#===============================
RUN echo "deb http://archive.ubuntu.com/ubuntu xenial main universe\n" > /etc/apt/sources.list \
  && echo "deb http://archive.ubuntu.com/ubuntu xenial-updates main universe\n" >> /etc/apt/sources.list \
  && echo "deb http://security.ubuntu.com/ubuntu xenial-security main universe\n" >> /etc/apt/sources.list

#===================================================================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#===================================================================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    bzip2 \
    ca-certificates \
    openjdk-8-jdk-headless \
    sudo \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

#=============
# Android SDK
#=============
ENV ANDROID_SDK_VERSION 24.4.1
RUN cd /opt \
  && wget --no-verbose http://dl.google.com/android/android-sdk_r$ANDROID_SDK_VERSION-linux.tgz -O android-sdk.tgz \
  && tar xzf android-sdk.tgz \
  && rm -f android-sdk.tgz
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
RUN cd $ANDROID_HOME \
  && mv tools/emulator tools/emulator-backup \
  && cp tools/emulator64-arm tools/emulator \
  && chmod +x tools/android tools/emulator

#=====================
# Android SDK Manager
#=====================
ENV AVD_VERSION 19
ENV ANDROID_COMPONENTS platform-tools,build-tools-24.0.0,android-$AVD_VERSION
RUN echo y | android update sdk --all --force --no-ui --filter ${ANDROID_COMPONENTS}

#================
# Nodejs and npm
#================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    nodejs \
    npm \
  && rm -rf /var/lib/apt/lists/* \
  && ln -s /usr/bin/nodejs /usr/bin/node

#============================================
# Add udev rules file with USB configuration
#============================================
ENV UDEV_REMOTE_FILE https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/ubuntu/51-android.rules
RUN mkdir /etc/udev/rules.d \
  && wget --no-verbose $UDEV_REMOTE_FILE -O /etc/udev/rules.d/51-android.rules

#========
# Appium
#========
ENV APPIUM_VERSION 1.5.3
RUN npm install -g appium@$APPIUM_VERSION

# Appium server port
EXPOSE 4723

CMD appium
