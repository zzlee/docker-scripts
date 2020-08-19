#!/bin/sh

. /etc/profile

echo ------------------------------------------------------------------------------------------------
echo TARGET=$TARGET

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
cmake .. -DBUILD_TARGET=$TARGET
make install

echo ------------------------------------------------------------------------------------------------
TARGET=ubuntu1804-cuda_x64

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
cmake .. -DBUILD_TARGET=$TARGET
make install
