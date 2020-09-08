#!/bin/sh

. /etc/profile

cd /home/zzlee/dev/h2_linux_sdk/ambarella/
. build/env/aarch64-linaro-gcc.env

cd /home/zzlee/dev/h2
mkdir -p build
cd build
H2_LINUX_SDK=/home/zzlee/dev/h2_linux_sdk cmake ../cmake

make $@ -j 4