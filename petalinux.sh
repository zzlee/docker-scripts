#!/bin/sh

DOCKER_IMAGE=${DOCKER_IMAGE:-yuan88yuan/petalinux:v2020.2}

echo DOCKER_IMAGE=${DOCKER_IMAGE}

./docker-run.sh \
	${DOCKER_IMAGE} \
	sudo su ${SUDO_USER}

