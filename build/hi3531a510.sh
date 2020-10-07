#!/bin/sh

. /etc/profile

TARGET=hi3531a510

cd /home/zzlee/dev/qcap-dev/qcap
mkdir -p build-$TARGET
cd build-$TARGET

if [ "$1" = "install" ]; then
	rm lib/* -r
	rm bin/* -r
fi

HI3531A510_SDK_HOME=/home/zzlee/dev/hi3531a-sdk/Hi3531A_SDK_V1.0.6.0 cmake .. -DBUILD_TARGET=$TARGET -DCMAKE_BUILD_TYPE=Release
make $@ -j 4