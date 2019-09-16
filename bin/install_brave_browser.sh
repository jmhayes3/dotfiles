#!/usr/bin/env bash

sudo apt install apt-transport-https curl

curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

source /etc/os-release

echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ bionic main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-bionic.list

sudo apt update

sudo apt install brave-browser
