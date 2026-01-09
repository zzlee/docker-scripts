#!/bin/sh

IMAGE=${IMAGE:-yuan88yuan/petalinux:ubuntu2204}
CONT=${CONT:-vivado-v2023.2}

echo IMAGE=${IMAGE}
echo CONT=${CONT}

xhost +
# sysctl -w fs.inotify.max_user_watches="99999999"
docker run -itd --rm --name ${CONT} \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        --device=/dev/dri \
	-e DISPLAY \
	-v ${PWD}/..:/docker \
	-v /opt:/opt \
	-v /etc/timezone:/etc/timezone \
	-v /etc/localtime:/etc/localtime \
	-v ~/petalinux-cache:/docker/cache \
	${IMAGE} $@
