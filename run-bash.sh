#!/bin/sh

. ./docker_env.sh

docker run --rm -it --name $1 -v ${DOCKER_HOME}:/home/zzlee/dev $REPO/$1:$TAG su -c /bin/bash -l zzlee
