#!/bin/sh

cd /docker/h2_linux_sdk/ambarella/
. build/env/aarch64-linaro-gcc.env

cd /docker/h2
mkdir -p build
cd build
H2_LINUX_SDK=/docker/h2_linux_sdk cmake ../cmake

make $@ -j 4