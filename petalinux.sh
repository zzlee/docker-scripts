#!/bin/sh

DOCKER_IMAGE=${DOCKER_IMAGE:-yuan88yuan/petalinux:v2020.2}
CONT=${CONT:-petalinux}

echo DOCKER_IMAGE=${DOCKER_IMAGE}
echo CONT=${CONT}

# sysctl -w fs.inotify.max_user_watches="99999999"
./docker-run.sh -d -t \
	--volume /home/zzlee/petalinux-cache:/docker/cache \
	--name ${CONT} \
	${DOCKER_IMAGE} \
	su - ${USER}

