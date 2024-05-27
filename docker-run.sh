#!/bin/bash

docker run -it \
	--rm \
	--init \
	--workdir /docker \
	--volume $(pwd)/..:/docker \
	--env=HOST_UID=${UID} \
	--env=HOST_GID=`id -g` \
	--env=USER=${USER} \
	--volume="/etc/localtime:/etc/localtime:ro" \
	--env="DISPLAY" \
	--env="QT_X11_NO_MITSHM=1" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--device=/dev/dri \
	--group-add video $@
