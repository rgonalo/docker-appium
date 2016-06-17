Android Debug Image
===================

Docker image with Android SDK, Android emulator and a VNC Server to allow you to visually see the Android emulator.
Since it runs additional services to support this it is too heavy weight for usage to automate tests.

This image has been created based on Selenium NodeFirefoxDebug image: https://github.com/SeleniumHQ/docker-selenium/blob/master/NodeFirefoxDebug

How to use this image
---------------------

Launch the image:

``` bash
$ docker run -d -P rgonalo/android-debug
```

You can acquire the port that the VNC server is exposed to by running:

``` bash
$ docker port <container-name|container-id> 5900
#=> 0.0.0.0:49338
```

When you are prompted for the password it is __secret__.
