#!/bin/sh

IMAGE=$1
TARGET=$2

shift 2

echo "Building ${TARGET} @ ${IMAGE}... $@"
./docker-run.sh ${IMAGE} "su ${SUDO_USER} -c /bin/bash --login -c /docker/docker-scripts/build/${TARGET}.sh $@"