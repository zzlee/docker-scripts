#!/bin/sh

IMAGE=$1
REPO=ubuntu1804-zzlee.local:5000
TAG=v1

IMAGE_PATH=${REPO}/${IMAGE}:${TAG}

mkdir tmp
cd tmp

echo FROM ${IMAGE_PATH} > Dockerfile
echo "RUN echo zzlee:zzlee | chpasswd" >> Dockerfile
echo USER zzlee >> Dockerfile

cat Dockerfile

docker build -t ${IMAGE} .
cd ..

rm tmp -r