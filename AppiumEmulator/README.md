Appium Emulator
===============

Appium server to run tests on Android emulators.

How to use this image
---------------------

### Launch the image

##### Option 1: launch the image specifying local ports

``` bash
$ docker run -d -p APPIUM_LOCAL_PORT:4723 --name appium-emulator rgonalo/appium-emulator
```

##### Option 2: launch the image using any free local ports

``` bash
$ docker run -d -P --name appium-emulator rgonalo/appium-emulator
```

Appium server exposed port can be get by running:

``` bash
$ docker port appium-emulator
#=> 0.0.0.0:49412
```

Where `APPIUM_LOCAL_PORT = 49412`

### Run Appium tests

Execute your Appium tests on the remote server *127.0.0.1:APPIUM_LOCAL_PORT*. The test will be executed in a Nexus S
emulator with Android 4.4 (API 19).

To tail Appium server logs, execute following docker command:

``` bash
$ docker logs --follow appium-emulator
```

To install an APK, copy the APK file into the container and then install it with adb from container:

``` bash
$ docker cp APK_FILE appium-emulator:/
$ docker exec -it appium-emulator adb install APK_FILE
```
