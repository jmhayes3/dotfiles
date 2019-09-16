#!/usr/bin/env bash

# brew install socat
# brew cask install xquartz
# open -a XQuartz

socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
# in another window
# docker run -e DISPLAY=192.168.59.3:0 jess/geary
