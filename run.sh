#!/bin/sh

REPO=ubuntu1804-zzlee.local:5000
TAG=v1

docker run --rm -it --name $1 -v $(pwd):/home/zzlee/dev $REPO/$1:$TAG su -c /bin/bash -l zzlee