#!/bin/sh

. ./docker_env.sh
IMAGE=$1
shift

docker run --rm -it --name $IMAGE -v ${DOCKER_HOME}:/home/zzlee/dev $@ $REPO/$IMAGE:$TAG
