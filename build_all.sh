#!/bin/bash
if [ -z "$1" ]; then
  echo "TAG is not supplied, using latest"
  TAG=latest
else
  TAG=$1
fi

update_tag () {
   sed '1 s/:.*$/:'$2'/' $1/Dockerfile -i
}

# Update Dockerfile base tag
update_tag AppiumDebug $TAG
update_tag AppiumEmulator $TAG
update_tag AppiumEmulatorDebug $TAG

# Build images
docker build -t rgonalo/appium:$TAG Appium
docker build -t rgonalo/appium-debug:$TAG AppiumDebug
docker build -t rgonalo/appium-emulator:$TAG AppiumEmulator
docker build -t rgonalo/appium-emulator-debug:$TAG AppiumEmulatorDebug

# Recover Dockerfile base tag
update_tag AppiumDebug latest
update_tag AppiumEmulator latest
update_tag AppiumEmulatorDebug latest
