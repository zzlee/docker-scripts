#!/bin/bash

cd ./build-3rdparty/hi3531d/iconv
. /etc/profile

SYSROOT=/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target

function build_one
{
    ./configure \
        --prefix=${SYSROOT}/usr \
        --enable-static \
        --disable-shared \
        --host=$CROSS && \
    make && make install && touch DONE
}

EXTRA_CFLAGS="-march=armv7-a -mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon -mno-unaligned-access -fno-aggressive-loop-optimizations"
export CFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
export CXXFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
export TARGETMACH=arm-hisiv500-linux
export BUILDMACH=i686-pc-linux-gnu
export CROSS=arm-hisiv500-linux
export CC=${CROSS}-gcc
export LD=${CROSS}-ld
export AS=${CROSS}-as

build_one