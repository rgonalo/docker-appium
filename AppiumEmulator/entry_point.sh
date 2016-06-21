#!/bin/bash

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

# Starts Appium server in a virtual display
GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"
SERVER_NUM=$(echo $DISPLAY | sed -r -e 's/([^:]+)?:([0-9]+)(\.[0-9]+)?/\2/')
xvfb-run -n $SERVER_NUM --server-args="-screen 0 $GEOMETRY -ac +extension RANDR" \
  appium &
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

# Starts Android emulator in a virtual display
DISPLAY=$DISPLAY emulator -avd android-$AVD_VERSION &

trap shutdown SIGTERM SIGINT
wait $NODE_PID
