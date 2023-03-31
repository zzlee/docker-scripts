#!/bin/sh

DOCKER_IMAGE=${DOCKER_IMAGE:-yuan88yuan/vivado:v2020.2}
MAC_ADDR=${MAC_ADDR:-e0:d5:5e:66:22:b7}
#MAC_ADDR=${MAC_ADDR:-02:42:ac:11:00:03}

xhost +
./docker-run.sh \
	--privileged \
	--mac-address ${MAC_ADDR} \
	-v /sys/devices/:/sys/devices ${DOCKER_IMAGE} \
	sudo DISPLAY=${DISPLAY} su ${SUDO_USER}
