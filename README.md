# wine-docker

A docker image for containerizing wine applications.

For this image to work with a GUI program, you will need to forward your X11 display. For example:

``` 
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix wine-docker wine notepad.exe
```
