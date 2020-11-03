#!/bin/sh

IMAGE_NAME=$1
TAG=$2
SHA256=$(./show-sha256.sh ${IMAGE_NAME} ${TAG})
URL=http://localhost:5000/v2/${IMAGE_NAME}/manifests/${SHA256}

echo curl -v --silent -H "Accept: application/vnd.docker.distribution.manifest.v2+json" -X DELETE ${URL}
