#!/bin/sh

DOCKER_IMAGE=${DOCKER_IMAGE:-yuan88yuan/petalinux:v2020.2}
CONT=${CONT:-petalinux}

echo DOCKER_IMAGE=${DOCKER_IMAGE}
echo CONT=${CONT}

# sysctl -w fs.inotify.max_user_watches="99999999"
./docker-run.sh -d -t \
	-v ~/petalinux-cache:/docker/cache \
	-v /opt/:/opt/ \
	--name ${CONT} \
	${DOCKER_IMAGE} \
	$@

