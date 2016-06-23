Appium Emulator
===============

Appium server to run tests on Android emulators.

How to use this image
---------------------

Launch the image:

``` bash
$ docker run -d -P --name appium-emulator rgonalo/appium-emulator
```

You can acquire the port that the Appium server is exposed to by running:

``` bash
$ docker port appium-emulator 4723
#=> 0.0.0.0:49412
```

Finally, you can execute your Appium tests on the remote server CONTAINER_IP:49412.
