# Run Brave in a container
#
# docker run -it \
#	--net host \ # may as well YOLO
#	--cpuset-cpus 0 \ # control the cpu
#	--memory 512mb \ # max memory it can use
#	-v /tmp/.X11-unix:/tmp/.X11-unix \ # mount the X11 socket
#	-e DISPLAY=unix$DISPLAY \
#	-v $HOME/.config/brave-browser/:/data \ # if you want to save state
#	--security-opt seccomp=$HOME/chrome.json \
#	--name brave \
#	jess/chrome
#
# You will want the custom seccomp profile:
# 	wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ~/brave.json

# Base docker image
FROM ubuntu:18.04

# Install Brave
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	libcanberra-gtk* \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpango1.0-0 \
	libpulse0 \
	libv4l-0 \
	--no-install-recommends \
	&& curl -sSL https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - \
	&& echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ bionic main" | tee /etc/apt/sources.list.d/brave-browser-release-bionic.list \
	&& apt-get update && apt-get install -y \
	brave-browser \
	&& apt-get purge --auto-remove -y curl \
	&& rm -rf /var/lib/apt/lists/*

# Add brave group/user
RUN groupadd -r brave
RUN useradd -r -g brave brave
RUN mkdir -p /home/brave && chown -R brave:brave /home/brave

# Run Brave as non privileged user
USER brave

# Autorun Brave
ENTRYPOINT [ "brave-browser" ]
CMD [ "--user-data-dir=/data" ]
