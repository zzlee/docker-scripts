#!/bin/bash

IMAGE=$1
CONT=$2
EXTRA_OPTS=${EXTRA_OPTS:-""}

echo IMAGE=$IMAGE
echo CONT=$CONT
echo EXTRA_OPTS=$EXTRA_OPTS

docker run -d -t \
	--workdir /docker \
	--volume $(pwd)/..:/docker \
	--env=HOST_UID=${UID} \
	--env=HOST_GID=`id -g` \
	--env=USER=${USER} \
	-v "/etc/localtime:/etc/localtime:ro" \
	--name $CONT \
	${EXTRA_OPTS} \
	$IMAGE bash
