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
    openjdk-8-jre-headless \
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
  && chmod +x tools/android tools/emulator64-arm

#=====================
# Android SDK Manager
#=====================
ENV AVD_VERSION 19
ENV ANDROID_COMPONENTS platform-tools,build-tools-24.0.0,android-$AVD_VERSION,sys-img-armeabi-v7a-android-$AVD_VERSION
RUN echo y | android update sdk --all --force --no-ui --filter ${ANDROID_COMPONENTS}

#========================================
# Add normal user with passwordless sudo
#========================================
RUN sudo useradd appiumuser --shell /bin/bash --create-home \
  && sudo usermod -a -G sudo appiumuser \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
&& echo 'appiumuser:secret' | chpasswd

USER appiumuser

#==================
# Android Emulator
#==================
RUN android create avd --force --name android-$AVD_VERSION --target android-$AVD_VERSION \
  --device "Nexus 5" --abi armeabi-v7a --skin WVGA800
