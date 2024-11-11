#!/bin/bash

IMAGE=${IMAGE:-yuan88yuan/l4t-build}
CONT=${CONT:-l4t-build}

docker run -dt \
	--privileged \
	--workdir /docker \
	-v `realpath ~/docker`:/docker \
	-v "/etc/localtime:/etc/localtime:ro" \
	-v /var/run/:/var/run/ \
	--name $CONT \
	$IMAGE bash

