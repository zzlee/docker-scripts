#!/bin/sh

IMAGE_NAME=$1
SHA256=$2
URL=http://localhost:5000/v2/${IMAGE_NAME}/manifests/${SHA256}

echo curl -v --silent -H "Accept: application/vnd.docker.distribution.manifest.v2+json" -X DELETE ${URL}
