#!/bin/sh

REPO=ubuntu1804-zzlee.local:5000
TAG=v1
RUN_ARGS="--rm -a stdout -a stderr -v ${HOME}:/home/zzlee/dev/"
TARGET=$1

echo "Building $TARGET..."
docker run $RUN_ARGS $REPO/$TARGET:$TAG su zzlee -c "/bin/bash -c /home/zzlee/dev/docker-scripts/build/$TARGET.sh"