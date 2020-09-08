#!/bin/sh

. /etc/profile

TARGET=debian105-cuda_x64

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
cmake .. -DBUILD_TARGET=$TARGET
make $@ -j 4
