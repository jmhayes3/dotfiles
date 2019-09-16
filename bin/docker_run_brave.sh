#!/usr/bin/env bash

# You will want the custom seccomp profile:
# wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ~/chrome.json

open -a XQuartz

# needed to tunnel display from container to XQuartz
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &

# docker run -it \
#   --rm # rm named container if it already exists
#   --net host \ # access to the network
#   --cpuset-cpus 0 \ # cpu to use
#   --memory 512mb \ # max memory it can use
#   -v /tmp/.X11-unix:/tmp/.X11-unix \ # mount the X11 socket
#   -e DISPLAY=docker.for.mac.host.internal:0 # set DISPLAY var equal to host ip
#   -v $HOME/Shared/Docker/data/google-chrome/:/data \ # to save state
#   --security-opt seccomp=$HOME/Shared/chrome.json \
#   --name chrome
#   jess/chrome

docker run -it --rm --net host --cpuset-cpus 0 --memory 2048mb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=docker.for.mac.host.internal:0 -v $HOME/Shared/Docker/Volumes/brave/:/data --security-opt seccomp=$HOME/Shared/Docker/seccomp/brave.json --name brave brave
