#!/bin/bash

# Starts Android emulator in headless mode
emulator -avd android-$AVD_VERSION -no-window -no-boot-anim &
adb wait-for-device

# Starts Appium
appium
