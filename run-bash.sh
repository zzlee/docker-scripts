#!/bin/bash

IMAGE=$1
shift

docker run --rm -it --name ${IMAGE} -v $(pwd)/..:/home/zzlee/dev $@ ${IMAGE}
