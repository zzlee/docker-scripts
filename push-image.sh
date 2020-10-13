#!/bin/sh

REPO=qcap-registry:5000
TAG=v1

IMAGE=$1
docker push ${REPO}/${IMAGE}:${TAG}
