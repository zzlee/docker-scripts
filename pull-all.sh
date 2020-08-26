#!/bin/sh

REPO=ubuntu1804-zzlee.local:5000
TAG=v1

IMAGE=hisiv
docker pull ${REPO}/${IMAGE}:${TAG}

IMAGE=h2_linux_sdk
docker pull ${REPO}/${IMAGE}:${TAG}

IMAGE=mxe-avbase
docker pull ${REPO}/${IMAGE}:${TAG}

IMAGE=ubuntu1804_x64
docker pull ${REPO}/${IMAGE}:${TAG}

IMAGE=ubuntu1604_x64
docker pull ${REPO}/${IMAGE}:${TAG}

IMAGE=centos76_x64
docker pull ${REPO}/${IMAGE}:${TAG}