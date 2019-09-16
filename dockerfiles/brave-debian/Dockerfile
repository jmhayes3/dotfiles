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
#
# Run notify-osd in a container
# Needs X11 socket and dbus mounted
#
# docker run -d \
#	-v /etc/machine-id:/etc/machine-id:ro \
#	-v /etc/localtime:/etc/localtime:ro \
#	-v /tmp/.X11-unix:/tmp/.X11-unix \
#	-v /var/run/dbus:/var/run/dbus \
#	-v /var/run/user/$(id -u):/var/run/user/$(id -u) \
#	$(env | cut -d= -f1 | awk '{print "-e", $1}') \
#	-e DISPLAY=unix$DISPLAY \
#	-e DBUS_SESSION_BUS_ADDRESS="unix:path=/var/run/user/1000/bus" \
#	-v /etc/passwd:/etc/passwd:ro \
#	-v /etc/group:/etc/group:ro \
#	-u $(whoami) -w "$HOME" \
#	-v $HOME/.Xauthority:$HOME/.Xauthority \
#	--name notify-osd \
#	jess/notify-osd

# Base docker image
FROM debian:stretch-slim

# Install Brave
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	curl \
	gnupg \
	dbus \
	dbus-x11 \
	at-spi2-core \
	ca-certificates \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libnotify-bin \
	notify-osd \
	&& curl -sSL https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - \
	&& echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ trusty main" | tee /etc/apt/sources.list.d/brave-browser-release-trusty.list \
	&& apt-get update && apt-get install -y \
	brave-browser \
	&& apt-get purge --auto-remove -y curl \
	&& rm -rf /var/lib/apt/lists/*

# Add Brave group/user
# RUN groupadd -r brave && useradd -r -g brave brave && mkdir -p /home/brave && chown -R brave:brave /home/brave

ENV HOME /home/user

RUN useradd --create-home --home-dir $HOME user \
	&& mkdir -p $HOME/.cache/dconf \
	&& mkdir -p $HOME/.dbus \
	&& chown -R user:user $HOME

COPY local.conf /etc/fonts/local.conf

# To enable notification service
COPY org.freedesktop.Notifications.service /usr/share/dbus-1/services/org.freedesktop.Notifications.service

WORKDIR $HOME

USER user

# Autorun notify-osd
ENTRYPOINT [ "/usr/lib/x86_64-linux-gnu/notify-osd" ]
