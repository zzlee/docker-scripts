#!/bin/sh

TARGET=hi3531d

cd /docker/qcap-dev/qcap
mkdir -p build-$TARGET
cd build-$TARGET

if [ "$1" = "install" ]; then
	rm lib/* -r
	rm bin/* -r
fi

HI3531D_SDK_HOME=/docker/hi3531d-sdk/Hi3531DV100_SDK_V1.0.4.0 cmake .. -DBUILD_TARGET=$TARGET -DCMAKE_BUILD_TYPE=Release
make $@ -j 4