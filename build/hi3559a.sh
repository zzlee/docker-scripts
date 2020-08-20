#!/bin/sh

. /etc/profile

TARGET=hi3559a

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
HI3559A_SDK_HOME=/home/zzlee/dev/hi3559a-sdk/Hi3559AV100_SDK_V2.0.2.0 cmake .. -DBUILD_TARGET=$TARGET
make install
