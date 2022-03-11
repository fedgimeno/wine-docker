# wine-docker

A docker image for containerizing wine applications.

## Building the image

In the root directory of this project, open a terminal and run:

```docker build -t wine-docker .```

This will take a long time so be aware.

## Usage

For this image to work with a GUI program, you will need to forward your X11 display. For example:

``` 
docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix wine-docker wine notepad.exe
```
