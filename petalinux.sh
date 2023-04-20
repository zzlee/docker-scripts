#!/bin/sh

DOCKER_IMAGE=${DOCKER_IMAGE:-yuan88yuan/petalinux:v2020.2}

./docker-run.sh \
	${DOCKER_IMAGE} \
	sudo su ${SUDO_USER}

