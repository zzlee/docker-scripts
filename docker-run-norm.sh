#!/bin/bash

IMAGE=$1
shift

docker run -it \
	--workdir /docker \
	--volume $(pwd)/..:/docker \
	--env=HOST_UID=${SUDO_UID} \
	--env=HOST_GID=${SUDO_GID} \
	--env=USER=${SUDO_USER} \
	--volume="${HOME}/.ssh:/home/${SUDO_USER}/.ssh" \
	--volume="${HOME}/.gitconfig:/home/${SUDO_USER}/.gitconfig" \
	--volume="/etc/localtime:/etc/localtime:ro" \
	--env="DISPLAY" \
	--env="QT_X11_NO_MITSHM=1" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" ${IMAGE} $@
