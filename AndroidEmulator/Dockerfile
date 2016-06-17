FROM rgonalo/android
MAINTAINER Ruben Gonzalez Alonso <rgonalo@gmail.com>

#=====================
# Android SDK Manager
#=====================
ENV AVD_VERSION 19
ENV ANDROID_COMPONENTS sys-img-armeabi-v7a-android-$AVD_VERSION
RUN echo y | android update sdk --all --force --no-ui --filter ${ANDROID_COMPONENTS}
# RUN chmod 666 /tmp/adb.log

USER appiumuser

#==================
# Android Emulator
#==================
RUN android create avd --force --name android-$AVD_VERSION --target android-$AVD_VERSION \
  --device "Nexus 5" --abi armeabi-v7a --skin WVGA800 --snapshot

#==============================================
# Start and stop emulator to create a snapshot
#==============================================
# RUN emulator64-arm -avd android-$AVD_VERSION -snapshot android-$AVD_VERSION -no-window
# RUN xvfb-run -n 99 --server-args="-screen 0 1360x1020x24 -ac +extension RANDR" \
#    /opt/android-sdk-linux/tools/emulator64-arm -avd android-19 -snapshot android-19
# ENV WAIT_CMD "$ANDROID_HOME/platform-tools/adb wait-for-device shell getprop init.svc.bootanim"
# RUN until $WAIT_CMD | grep -m 1 stopped; do echo "Waiting for emulator ..."; sleep 10; done
# RUN adb emu kill
