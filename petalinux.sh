#!/bin/sh

IMAGE=${IMAGE:-yuan88yuan/petalinux:base}
CONT=${CONT:-petalinux}
EXTRA_OPTS=${EXTRA_OPTS:-"-v /opt/:/opt/"}
CMDS=${CMDS:-bash}

echo IMAGE=${IMAGE}
echo CONT=${CONT}
echo EXTRA_OPTS=$EXTRA_OPTS

# sysctl -w fs.inotify.max_user_watches="99999999"
./docker-run.sh -d -t \
	--name ${CONT} \
	-v ~/petalinux-cache:/docker/cache \
	${EXTRA_OPTS} \
	${IMAGE} \
	${CMDS}

