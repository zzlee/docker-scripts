#!/bin/sh

DOCKER_IMAGE=${DOCKER_IMAGE:-yuan88yuan/vivado:v2020.2}
MAC_ADDR=${MAC_ADDR:-e0:d5:5e:66:22:b7}
#MAC_ADDR=${MAC_ADDR:-02:42:ac:11:00:03}
CONT=${CONT:-vivado}

echo DOCKER_IMAGE=$DOCKER_IMAGE
echo MAC_ADDR=$MAC_ADDR
echo CONT=$CONT

xhost +
./docker-run.sh -d -t \
	--init \
	--privileged \
	--mac-address ${MAC_ADDR} \
	--name ${CONT} \
	-v /sys/devices/:/sys/devices \
	-v /dev/:/dev/ \
	${DOCKER_IMAGE} \
	su - ${USER}
