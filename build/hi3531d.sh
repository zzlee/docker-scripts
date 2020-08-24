#!/bin/sh

. /etc/profile

TARGET=hi3531d

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
HI3531D_SDK_HOME=/home/zzlee/dev/hi3531d-sdk/Hi3531DV100_SDK_V1.0.4.0 cmake .. -DBUILD_TARGET=$TARGET
make install -j 4