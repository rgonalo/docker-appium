Appium Emulator Debug
=====================

Appium server to run tests on Android emulators and a VNC Server to allow you to visually see the Android emulator.
Since it runs additional services to support this it is too heavy weight for usage to automate tests.

This image has been created based on Selenium NodeFirefoxDebug image: 
https://github.com/SeleniumHQ/docker-selenium/blob/master/NodeFirefoxDebug

How to use this image
---------------------

#### Launch the image

``` bash
$ docker run -d -P --name appium-emulator-debug rgonalo/appium-emulator-debug
```

#### Get VNC port and Appium server ip and port

You can acquire the ports that the Appium and VNC servers are exposed to by running:

``` bash
$ docker port appium-emulator-debug
#=> 4723/tcp -> 0.0.0.0:49412
    5900/tcp -> 0.0.0.0:49413
```

In Linux, Appium server ip is *127.0.0.1*, but in Windows and Mac you must acquire the ip by running:

``` bash
$ docker-machine ip
#=> 192.168.99.100
```

#### Run Appium tests

Execute your Appium tests on the remote server *192.168.99.100:49412*. The test will be executed in a Nexus S emulator
with Android 4.4 (API 19).

You can tail Appium server logs with the following docker command:

``` bash
$ docker logs --follow appium-emulator-debug
```

Also, you can connect with a VNC Client to *192.168.99.100:49413* to view the Ubuntu desktop and the Android emulator.
The default VNC password is __secret__.

To install an APK, copy the APK file into the container and then install it with adb from container:

``` bash
$ docker cp APK_FILE appium-emulator-debug:/
$ docker exec -it appium-emulator-debug adb install APK_FILE
```
