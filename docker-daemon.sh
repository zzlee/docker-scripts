#!/bin/bash

IMAGE=$1
CONT=$2

docker run -d -t \
	--workdir /docker \
	--volume $(pwd)/..:/docker \
	--env=HOST_UID=${SUDO_UID} \
	--env=HOST_GID=${SUDO_GID} \
	--env=USER=${SUDO_USER} \
	--volume="/etc/localtime:/etc/localtime:ro" \
	--name $CONT \
	$IMAGE su - ${SUDO_USER}
