#!/bin/sh

. ./docker_env.sh

IMAGE=$1
TARGET=$2
RUN_ARGS="--rm -a stdout -a stderr -v ${DOCKER_HOME}:/home/zzlee/dev/"

echo "Building $TARGET @ $IMAGE..."
docker run $RUN_ARGS $REPO/$IMAGE:$TAG su zzlee -c "/bin/bash -c /home/zzlee/dev/docker-scripts/build/$TARGET.sh"
