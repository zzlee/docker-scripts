#!/bin/sh

TARGET=hi3559a

cd /docker/qcap-dev/qcap
mkdir -p build-$TARGET
cd build-$TARGET

if [ "$1" = "install" ]; then
	rm lib/* -r
	rm bin/* -r
fi

HI3559A_SDK_HOME=/docker/hi3559a-sdk/Hi3559AV100_SDK_V2.0.2.0 cmake .. -DBUILD_TARGET=$TARGET -DCMAKE_BUILD_TYPE=Release
make $@ -j 4
