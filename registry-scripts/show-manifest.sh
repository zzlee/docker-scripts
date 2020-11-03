#!/bin/sh

IMAGE_NAME=$1
TAG=$2

curl -v --silent -H "Accept: application/vnd.docker.distribution.manifest.v2+json" -X GET http://localhost:5000/v2/${IMAGE_NAME}/manifests/${TAG}
