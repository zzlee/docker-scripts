#!/bin/sh

. /etc/profile

TARGET=hi3531a

cd /home/zzlee/dev/qcap-dev/qcap
mkdir -p build-$TARGET
cd build-$TARGET

if [ "$1" = "install" ]; then
	rm lib/* -r
	rm bin/* -r
fi

HI3531A_SDK_HOME=/home/zzlee/dev/hi3531a-sdk/Hi3531A_SDK_V1.0.2.0 cmake .. -DBUILD_TARGET=$TARGET
make $@ -j 4