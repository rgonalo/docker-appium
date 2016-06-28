FROM rgonalo/appium:latest
MAINTAINER Ruben Gonzalez Alonso <rgonalo@gmail.com>

#===========================
# Android SDK Manager (API)
#===========================
ENV AVD_VERSION 19
ENV AVD_PACKAGE "system-images;android-$AVD_VERSION;default;armeabi-v7a"
RUN mkdir -p ~/.android && touch ~/.android/repositories.cfg
RUN echo y | sdkmanager "platforms;android-$AVD_VERSION"
RUN echo y | sdkmanager "$AVD_PACKAGE"

#=========================
# Create Android Emulator
#=========================
ENV DEVICE "Nexus S"
RUN avdmanager create avd --force --name "android-$AVD_VERSION" --package "$AVD_PACKAGE" --device "$DEVICE"

#============================================
# Scripts to run Appium and Android emulator
#============================================
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

CMD ["/opt/bin/entry_point.sh"]
