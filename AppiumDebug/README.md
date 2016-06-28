Android Debug
=============

Appium server to run tests on Android devices and a VNC Server to allow you to visually see the Ubuntu desktop.
Since it runs additional services to support this it is too heavy weight for usage to automate tests.

This image has been created based on Selenium NodeFirefoxDebug image: 
https://github.com/SeleniumHQ/docker-selenium/blob/master/NodeFirefoxDebug

How to use this image
---------------------

### Launch the image

##### Option 1: launch the image specifying local ports

Launch the image with *--privileged* option to allow docker instance to view connected USB devices:

``` bash
$ docker run -d -p APPIUM_LOCAL_PORT:4723 -p VNC_LOCAL_PORT:5900 --privileged -v /dev/bus/usb:/dev/bus/usb --name appium-debug rgonalo/appium-debug
```

##### Option 2: launch the image using any free local ports

``` bash
$ docker run -d -P --privileged -v /dev/bus/usb:/dev/bus/usb --name appium-debug rgonalo/appium-debug
```

Appium server and VNC server exposed ports can be get by running:

``` bash
$ docker port appium-debug
#=> 4723/tcp -> 0.0.0.0:49412
    5900/tcp -> 0.0.0.0:49413
```

Where `APPIUM_LOCAL_PORT = 49412` and `VNC_LOCAL_PORT = 49413`

### Run Appium tests

Connect your Android mobile to the host via USB and execute your Appium tests on the remote server
*127.0.0.1:APPIUM_LOCAL_PORT*.

To tail Appium server logs, execute following docker command:

``` bash
$ docker logs --follow appium-debug
```

To view the Ubuntu desktop, use a VNC Client to connect to *127.0.0.1:VNC_LOCAL_PORT*. The default VNC password
is __secret__.

To install an APK, copy the APK file into the container and then install it with adb from container:

``` bash
$ docker cp APK_FILE appium-debug:/
$ docker exec -it appium-debug adb install APK_FILE
```
