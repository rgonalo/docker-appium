Appium Image
============

Docker image for running Appium server with Android devices.

This image has been created based on Selenium Base image: https://github.com/SeleniumHQ/docker-selenium/tree/master/Base

How to use this image
---------------------

Launch the image:

``` bash
$ docker run -d -P --privileged -v /dev/bus/usb:/dev/bus/usb --name appium rgonalo/appium
```

The *--privileged* option allows docker instance to view connected USB devices.

You can acquire the port that the Appium server is exposed to by running:

``` bash
$ docker port appium 4723
#=> 0.0.0.0:49412
```
