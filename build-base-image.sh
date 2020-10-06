#!/bin/sh

IMAGE=$1
REPO=qcap-registry:5000
TAG=v1

IMAGE_PATH=${REPO}/${IMAGE}:${TAG}

mkdir tmp
cd tmp

cat <<EOF > Dockerfile
FROM ${IMAGE_PATH}

USER zzlee
WORKDIR /home/zzlee
ENTRYPOINT ["/bin/bash", "--login"]
EOF

cat Dockerfile

docker build -t ${IMAGE} .
cd ..

rm tmp -r
