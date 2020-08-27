#!/bin/sh

DOCKER_HOME=$(pwd)/..

echo Compact registry @ ${DOCKER_HOME}/registry

docker exec registry bin/registry garbage-collect -m /etc/docker/registry/config.yml
