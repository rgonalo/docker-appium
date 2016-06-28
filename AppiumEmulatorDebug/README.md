Appium Emulator Debug
=====================

Appium server to run tests on Android emulators and a VNC Server to allow you to visually see the Android emulator.
Since it runs additional services to support this it is too heavy weight for usage to automate tests.

This image has been created based on Selenium NodeFirefoxDebug image: 
https://github.com/SeleniumHQ/docker-selenium/blob/master/NodeFirefoxDebug

How to use this image
---------------------

### Launch the image

##### Option 1: launch the image specifying local ports

``` bash
$ docker run -d -p APPIUM_LOCAL_PORT:4723 -p VNC_LOCAL_PORT:5900 --name appium-emulator-debug rgonalo/appium-emulator-debug
```

##### Option 2: launch the image using any free local ports

``` bash
$ docker run -d -P --name appium-emulator-debug rgonalo/appium-emulator-debug
```

Appium server and VNC server exposed ports can be get by running:

``` bash
$ docker port appium-emulator-debug
#=> 4723/tcp -> 0.0.0.0:49412
    5900/tcp -> 0.0.0.0:49413
```

Where `APPIUM_LOCAL_PORT = 49412` and `VNC_LOCAL_PORT = 49413`

### Run Appium tests

Execute your Appium tests on the remote server *127.0.0.1:APPIUM_LOCAL_PORT*. The test will be executed in a Nexus S emulator
with Android 4.4 (API 19).

To tail Appium server logs, execute following docker command:

``` bash
$ docker logs --follow appium-emulator-debug
```

To view the Ubuntu desktop and the Android emulator, use a VNC Client to connect to *127.0.0.1:VNC_LOCAL_PORT*.
The default VNC password is __secret__.

To install an APK, copy the APK file into the container and then install it with adb from container:

``` bash
$ docker cp APK_FILE appium-emulator-debug:/
$ docker exec -it appium-emulator-debug adb install APK_FILE
```
