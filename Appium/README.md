Appium
======

Appium server to run tests on Android devices.

This image has been created based on Selenium Base image: https://github.com/SeleniumHQ/docker-selenium/tree/master/Base

How to use this image
---------------------

#### Launch the image

Launch the image with *--privileged* option to allow docker instance to view connected USB devices:

``` bash
$ docker run -d -P --privileged -v /dev/bus/usb:/dev/bus/usb --name appium rgonalo/appium
```

#### Get Appium server ip and port

You can acquire the port that the Appium server is exposed to by running:

``` bash
$ docker port appium
#=> 0.0.0.0:49412
```

In Linux, Appium server ip is *127.0.0.1*, but in Windows and Mac you must acquire the ip by running:

``` bash
$ docker-machine ip
#=> 192.168.99.100
```

#### Run Appium tests

Connect your Android mobile to the host via USB and execute your Appium tests on the remote server
*192.168.99.100:49412*.

You can tail Appium server logs with the following docker command:

``` bash
$ docker logs --follow appium
```

To install an APK, copy the APK file into the container and then install it with adb from container:

``` bash
$ docker cp APK_FILE appium:/
$ docker exec -it appium adb install APK_FILE
```
