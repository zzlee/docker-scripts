#!/bin/bash

cd /docker/qcap/build-3rdparty/hi3531a400/openssl

SYSROOT=/opt/hisi-linux/x86-arm/arm-hisiv400-linux/target

function build_one
{
    ./Configure linux-armv4 \
        --prefix=/docker/qcap/3rdparty/hi3531a400/ \
        no-shared \
        no-async && \
    make && make install && touch DONE
}

EXTRA_CFLAGS="-mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon -mno-unaligned-access -fno-aggressive-loop-optimizations"
export CFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
export CXXFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
PREFIX=arm-hisiv400-linux
export LDFLAGS="-lgcc"
export AR=${PREFIX}-ar
export AS=${PREFIX}-gcc
export CC=${PREFIX}-gcc
export CXX=${PREFIX}-g++
export LD=${PREFIX}-ld
export NM=${PREFIX}-nm
export RANLIB=${PREFIX}-ranlib
export STRIP=${PREFIX}-strip

build_one
