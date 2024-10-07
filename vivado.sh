#!/bin/sh

IMAGE=${IMAGE:-yuan88yuan/vivado:v2020.2}
MAC_ADDR=${MAC_ADDR:-e0:d5:5e:66:22:b7}
#MAC_ADDR=${MAC_ADDR:-02:42:ac:11:00:03}
CONT=${CONT:-vivado}
EXTRA_OPTS=${EXTRA_OPTS:-"-v /opt/:/opt/"}

echo IMAGE=$IMAGE
echo MAC_ADDR=$MAC_ADDR
echo CONT=$CONT
echo EXTRA_OPTS=$EXTRA_OPTS

xhost +
./docker-run.sh -d -t \
	--init \
	--privileged \
	--mac-address ${MAC_ADDR} \
	--name ${CONT} \
	-v /sys/devices/:/sys/devices \
	-v /dev/:/dev/ \
	${EXTRA_OPTS} \
	${IMAGE} \
	$@
