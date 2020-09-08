#!/bin/sh

. /etc/profile

TARGET=hi3519a

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
HI3519A_SDK_HOME=/home/zzlee/dev/hi3519a-sdk/Hi3519AV100_SDK_V2.0.2.0 cmake .. -DBUILD_TARGET=$TARGET
make $@ -j 4