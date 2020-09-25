#!/bin/sh

REPO=ubuntu1804-zzlee.local:5000
TAG=v1

IMAGE=$1
docker pull ${REPO}/${IMAGE}:${TAG}
