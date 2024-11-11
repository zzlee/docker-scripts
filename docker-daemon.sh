#!/bin/bash

IMAGE=$1
CONT=$2

docker run -d -t \
	--workdir /docker \
	--volume $(pwd)/..:/docker \
	--env=HOST_UID=${UID} \
	--env=HOST_GID=`id -g` \
	--env=USER=${USER} \
	--volume="/etc/localtime:/etc/localtime:ro" \
	--name $CONT \
	$IMAGE bash
