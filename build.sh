#!/bin/sh

IMAGE=$1
TARGET=$2

shift 2

echo "Building ${TARGET} @ ${IMAGE}... $@"
docker run --rm -a stdout -a stderr -v $(pwd)/..:/home/zzlee/dev/ ${IMAGE} /bin/bash -c "/home/zzlee/dev/docker-scripts/build/${TARGET}.sh $@"
