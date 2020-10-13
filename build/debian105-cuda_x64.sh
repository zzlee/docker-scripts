#!/bin/sh

TARGET=debian105-cuda_x64

cd /docker/qcap-dev/qcap
mkdir -p build-$TARGET
cd build-$TARGET

if [ "$1" = "install" ]; then
	rm lib/* -r
	rm bin/* -r
fi

cmake .. -DBUILD_TARGET=$TARGET -DCMAKE_BUILD_TYPE=Release
make $@ -j 4
