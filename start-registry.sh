#!/bin/sh

. ./docker_env.sh

echo Starting registry @ ${DOCKER_HOME}/registry

docker run --rm -d -p 5000:5000 -v ${DOCKER_HOME}/registry:/var/lib/registry --name registry registry:2