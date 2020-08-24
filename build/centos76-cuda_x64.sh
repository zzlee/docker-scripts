#!/bin/sh

. /etc/profile

TARGET=centos76-cuda_x64

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
cmake .. -DBUILD_TARGET=$TARGET
make install -j 4
