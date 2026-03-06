#!/bin/sh

IMAGE=${IMAGE:-yuan88yuan/petalinux:v2020.2}
CONT=${CONT:-petalinux-v2020.2}

echo IMAGE=${IMAGE}
echo CONT=${CONT}

# sysctl -w fs.inotify.max_user_watches="99999999"
docker run -itd --rm --name ${CONT} \
	-v ${PWD}/..:/docker \
	-v /opt:/opt \
	-v /etc/timezone:/etc/timezone \
	-v /etc/localtime:/etc/localtime \
	-v ~/petalinux-cache:/docker/cache \
	${IMAGE} $@
