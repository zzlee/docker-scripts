#!/bin/sh

IMAGE=$1
TARGET=$2

shift 2

ARGV=$@

echo "Building ${TARGET} @ ${IMAGE}... ${ARGV}"
./docker-run.sh ${IMAGE} /bin/bash --login -c \"/docker/docker-scripts/build/${TARGET}.sh $@\"