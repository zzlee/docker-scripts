#!/bin/sh

. /etc/profile

echo ------------------------------------------------------------------------------------------------
TARGET=hi3531a

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
HI3531A_SDK_HOME=/home/zzlee/dev/hi3531a-sdk/Hi3531A_SDK_V1.0.2.0 cmake .. -DBUILD_TARGET=$TARGET
make install

echo ------------------------------------------------------------------------------------------------
TARGET=hi3531a400

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
HI3531A400_SDK_HOME=/home/zzlee/dev/hi3531a-sdk/Hi3531A_SDK_V1.0.2.0 cmake .. -DBUILD_TARGET=$TARGET
make install

echo ------------------------------------------------------------------------------------------------
TARGET=hi3531d

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
HI3531D_SDK_HOME=/home/zzlee/dev/hi3531d-sdk/Hi3531DV100_SDK_V1.0.4.0 cmake .. -DBUILD_TARGET=$TARGET
make install

echo ------------------------------------------------------------------------------------------------
TARGET=hi3519a

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
HI3519A_SDK_HOME=/home/zzlee/dev/hi3519a-sdk/Hi3519AV100_SDK_V2.0.2.0 cmake .. -DBUILD_TARGET=$TARGET
make install

echo ------------------------------------------------------------------------------------------------
TARGET=hi3559a

cd /home/zzlee/dev/qcap-dev/qcap
mkdir build-$TARGET
cd build-$TARGET

rm lib/* -r
rm bin/* -r
HI3559A_SDK_HOME=/home/zzlee/dev/hi3559a-sdk/Hi3559AV100_SDK_V2.0.2.0 cmake .. -DBUILD_TARGET=$TARGET
make install
