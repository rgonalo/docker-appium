Android Debug
=============

Appium server to run tests on Android devices and a VNC Server to allow you to visually see the Ubuntu desktop.
Since it runs additional services to support this it is too heavy weight for usage to automate tests.

This image has been created based on Selenium NodeFirefoxDebug image: 
https://github.com/SeleniumHQ/docker-selenium/blob/master/NodeFirefoxDebug

How to use this image
---------------------

Launch the image:

``` bash
$ docker run -d -P --privileged -v /dev/bus/usb:/dev/bus/usb --name appium-debug rgonalo/appium-debug
```

The *--privileged* option allows docker instance to view connected USB devices.

You can acquire the port that the VNC server is exposed to by running:

``` bash
$ docker port appium-debug 5900
#=> 0.0.0.0:49413
```

The default VNC password is __secret__.
