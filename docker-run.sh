#!/bin/bash

IMAGE=$1
shift

sudo docker run -it \
	--workdir /docker \
	-v $(pwd)/..:/docker \
	--env=HOST_UID=$(id -u) \
	--env=HOST_GID=$(id -g) \
	--env=USER=${USER} \
	--volume="${HOME}/.ssh:/home/${USER}/.ssh" \
	--volume="${HOME}/.gitconfig:/home/${USER}/.gitconfig" \
	--volume="/etc/localtime:/etc/localtime:ro" \
	--env="DISPLAY" \
	--env="QT_X11_NO_MITSHM=1" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" ${IMAGE} $@
