Appium Emulator
===============

Appium server to run tests on Android emulators.

How to use this image
---------------------

#### Launch the image

``` bash
$ docker run -d -P --name appium-emulator rgonalo/appium-emulator
```

#### Get Appium server ip and port

You can acquire the port that the Appium server is exposed to by running:

``` bash
$ docker port appium-emulator 4723
#=> 0.0.0.0:49412
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
$ docker logs --follow appium-emulator
```
