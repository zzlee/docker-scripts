#!/bin/sh

IMAGE=$1
REPO=ubuntu1804-zzlee.local:5000
TAG=v1

IMAGE_PATH=${REPO}/${IMAGE}:${TAG}

mkdir tmp
cd tmp

cat <<EOF > Dockerfile
FROM ${IMAGE_PATH}

RUN echo zzlee:zzlee | chpasswd
USER zzlee
WORKDIR /home/zzlee
CMD ["/bin/bash", "-c", ". /etc/profile && /bin/bash"]
EOF

cat Dockerfile

docker build -t ${IMAGE} .
cd ..

rm tmp -r
