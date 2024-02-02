#!/bin/bash

docker run -it \
	--rm \
	--init \
	--workdir /docker \
	--volume $(pwd)/..:/docker \
	--env=HOST_UID=${SUDO_UID} \
	--env=HOST_GID=${SUDO_GID} \
	--env=USER=${SUDO_USER} \
	--volume="/etc/localtime:/etc/localtime:ro" $@
