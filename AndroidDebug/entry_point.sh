#!/bin/bash

# Starts android emulator in a virtual display
sudo -E -i -u appiumuser \
  DISPLAY=:99.0 \
  xvfb-run -n 99 --server-args="-screen 0 1360x1020x24 -ac +extension RANDR" \
  /opt/android-sdk-linux/tools/emulator64-arm -avd android-$AVD_VERSION &
NODE_PID=$!

# Waits until xvfb is started
for i in $(seq 1 10)
do
  xdpyinfo -display $DISPLAY >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    break
  fi
  echo Waiting xvfb...
  sleep 0.5
done

# Starts fluxbox and vnc
fluxbox -display $DISPLAY &
x11vnc -forever -usepw -shared -rfbport 5900 -display $DISPLAY &

wait $NODE_PID
