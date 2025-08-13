#!/bin/sh

IMAGE=${IMAGE:-yuan88yuan/petalinux:ubuntu2204}
CONT=${CONT:-petalinux-2024.2}

echo IMAGE=${IMAGE}
echo CONT=${CONT}

# sysctl -w fs.inotify.max_user_watches="99999999"
docker run -itd --rm --name ${CONT} -v ${PWD}/..:/docker -v /opt:/opt -v ~/petalinux-cache:/docker/cache ${IMAGE} $@
