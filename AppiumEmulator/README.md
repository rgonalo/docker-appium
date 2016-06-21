Appium Emulator Image
=====================

Docker image for running Appium server with Android emulators.

How to use this image
---------------------

Launch the image:

``` bash
$ docker run -d -P --name appium-emulator rgonalo/appium-emulator
```

You can acquire the port that the Appium server is exposed to by running:

``` bash
$ docker port appium 4723
#=> 0.0.0.0:49412
```
