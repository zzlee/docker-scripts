#!/bin/bash

cd /docker/qcap/build-3rdparty/hi3531a400/uuid

SYSROOT=/opt/hisi-linux/x86-arm/arm-hisiv400-linux/target

function build_one
{
    aclocal && autoconf && autoheader && libtoolize && automake -a && \
    ./configure \
        --prefix=/docker/qcap/3rdparty/hi3531a400/ \
        --enable-static \
        --disable-shared \
        --host=$CROSS && \
    make && make install && touch DONE
}

EXTRA_CFLAGS="-mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon -mno-unaligned-access -fno-aggressive-loop-optimizations"
export CFLAGS="-Ofast -fPIC $EXTRA_CFLAGS"
export CXXFLAGS="-Ofast -fPIC $EXTRA_CFLAGS"
export TARGETMACH=arm-hisiv400-linux
export BUILDMACH=i686-pc-linux-gnu
export CROSS=arm-hisiv400-linux
export CC=${CROSS}-gcc
export LD=${CROSS}-ld
export AS=${CROSS}-as

build_one
