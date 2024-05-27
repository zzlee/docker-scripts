#!/bin/sh

DOCKER_IMAGE=${DOCKER_IMAGE:-yuan88yuan/petalinux:v2020.2}

echo DOCKER_IMAGE=${DOCKER_IMAGE}

sysctl -w fs.inotify.max_user_watches="99999999"
./docker-run.sh \
	--volume /home/zzlee/petalinux-cache:/docker/cache \
	${DOCKER_IMAGE} \
	sudo su ${SUDO_USER}

