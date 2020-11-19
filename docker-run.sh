#!/bin/bash

DOCKER_ARGS=${DOCKER_ARGS}
IMAGE=$1
shift

docker run -it \
	--workdir /docker \
	--volume $(pwd)/..:/docker \
	--env=HOST_UID=${SUDO_UID} \
	--env=HOST_GID=${SUDO_GID} \
	--env=USER=${SUDO_USER} \
	--volume="/etc/localtime:/etc/localtime:ro" \
	--env="DISPLAY" \
	--env="QT_X11_NO_MITSHM=1" \
	--mac-address="02:42:ac:11:00:03" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	${DOCKER_ARGS} ${IMAGE} $@
