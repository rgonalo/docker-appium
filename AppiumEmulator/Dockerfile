FROM rgonalo/appium:latest
MAINTAINER Ruben Gonzalez Alonso <rgonalo@gmail.com>

#===========================
# Android SDK Manager (API)
#===========================
ENV AVD_VERSION 19
ENV ANDROID_COMPONENTS android-$AVD_VERSION,sys-img-armeabi-v7a-android-$AVD_VERSION
RUN echo y | android update sdk --all --force --no-ui --filter ${ANDROID_COMPONENTS}

#=========================
# Create Android Emulator
#=========================
RUN android create avd --force --name android-$AVD_VERSION --target android-$AVD_VERSION \
  --device "Nexus S" --abi armeabi-v7a --skin WVGA800 --snapshot

#============================================
# Scripts to run Appium and Android emulator
#============================================
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

#============================
# Some configuration options
#============================
ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

#==============================================
# Start and stop emulator to create a snapshot
#==============================================
ENV GEOMETRY "$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"
ENV WAIT_EMULATOR_CMD adb wait-for-device shell getprop init.svc.bootanim
ENV WAIT_SNAPSHOT_CMD emulator -avd android-$AVD_VERSION -snapshot-list
RUN xvfb-run -n 99 --server-args="-screen 0 $GEOMETRY -ac +extension RANDR" \
  emulator -avd android-$AVD_VERSION -snapshot appium & \
  until $WAIT_EMULATOR_CMD | grep -m 1 stopped; do echo "Waiting for emulator ..."; sleep 10; done \
  && kill -2 $(pidof emulator) \
  && until $WAIT_SNAPSHOT_CMD | grep appium; do echo "Waiting for snapshot ..."; sleep 5; done

CMD ["/opt/bin/entry_point.sh"]
