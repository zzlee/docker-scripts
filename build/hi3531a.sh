#!/bin/sh

TARGET=hi3531a

cd /docker/qcap-dev/qcap
mkdir -p build-$TARGET
cd build-$TARGET

if [ "$1" = "install" ]; then
	rm lib/* -r
	rm bin/* -r
fi

HI3531A_SDK_HOME=/docker/hi3531a-sdk/Hi3531A_SDK_V1.0.2.0 cmake .. -DBUILD_TARGET=$TARGET -DCMAKE_BUILD_TYPE=Release
make $@ -j 4
