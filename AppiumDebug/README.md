Android Debug
=============

Appium server to run tests on Android devices and a VNC Server to allow you to visually see the Ubuntu desktop.
Since it runs additional services to support this it is too heavy weight for usage to automate tests.

This image has been created based on Selenium NodeFirefoxDebug image: 
https://github.com/SeleniumHQ/docker-selenium/blob/master/NodeFirefoxDebug

How to use this image
---------------------

#### Launch the image

Launch the image with *--privileged* option to allow docker instance to view connected USB devices:

``` bash
$ docker run -d -P --privileged -v /dev/bus/usb:/dev/bus/usb --name appium-debug rgonalo/appium-debug
```

#### Get VNC port and Appium server ip and port

You can acquire the ports that the Appium and VNC servers are exposed to by running:

``` bash
$ docker port appium-debug
#=> 4723/tcp -> 0.0.0.0:49412
    5900/tcp -> 0.0.0.0:49413
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
$ docker logs --follow appium-debug
```

Also, you can connect with a VNC Client to *192.168.99.100:49413* to view the Ubuntu desktop. The default VNC password
is __secret__.

To install an APK, copy the APK file into the container and then install it with adb from container:

``` bash
$ docker cp APK_FILE appium-debug:/
$ docker exec -it appium-debug adb install APK_FILE
```
