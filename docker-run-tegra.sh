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
	--gpus all \
	$@
