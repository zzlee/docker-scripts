#!/bin/sh

IMAGE_NAME=$1
TAG=$2
SHA256=$(./show-sha256.sh ${IMAGE_NAME} ${TAG})

./rm-image-sha256.sh ${IMAGE_NAME} ${SHA256}
