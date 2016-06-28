Appium
======

Appium server to run tests on Android devices.

This image has been created based on Selenium Base image: https://github.com/SeleniumHQ/docker-selenium/tree/master/Base

How to use this image
---------------------

### Launch the image

##### Option 1: launch the image specifying local ports

Launch the image with *--privileged* option to allow docker instance to view connected USB devices:

``` bash
$ docker run -d -p APPIUM_LOCAL_PORT:4723 --privileged -v /dev/bus/usb:/dev/bus/usb --name appium rgonalo/appium
```

##### Option 2: launch the image using any free local ports

``` bash
$ docker run -d -P --privileged -v /dev/bus/usb:/dev/bus/usb --name appium rgonalo/appium
```

Appium server exposed port can be get by running:

``` bash
$ docker port appium
#=> 0.0.0.0:49412
```

Where `APPIUM_LOCAL_PORT = 49412`

### Run Appium tests

Connect your Android mobile to the host via USB and execute your Appium tests on the remote server
*127.0.0.1:APPIUM_LOCAL_PORT*.

To tail Appium server logs, execute following docker command:

``` bash
$ docker logs --follow appium
```

To install an APK, copy the APK file into the container and then install it with adb from container:

``` bash
$ docker cp APK_FILE appium:/
$ docker exec -it appium adb install APK_FILE
```
