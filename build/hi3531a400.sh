#!/bin/sh

. /etc/profile

TARGET=hi3531a400

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
HI3531A400_SDK_HOME=/home/zzlee/dev/hi3531a-sdk/Hi3531A_SDK_V1.0.2.0 cmake .. -DBUILD_TARGET=$TARGET
make $@ -j 4