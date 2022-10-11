#!/bin/bash

cd ./build-3rdparty/hi3531a/zlib
. /etc/profile

SYSROOT=/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target

function build_one
{
    ./configure \
        --prefix=${SYSROOT} \
        --static && \
    make && make install && touch DONE
}

EXTRA_CFLAGS="-mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon -mno-unaligned-access -fno-aggressive-loop-optimizations"
export CFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
export CXXFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
# export INSTALLDIR=$_PWD/arm-hisiv300-linux
# export PATH=$INSTALLDIR/bin:$PATH
export TARGETMACH=arm-hisiv300-linux
export BUILDMACH=i686-pc-linux-gnu
export CROSS=arm-hisiv300-linux
export CC=${CROSS}-gcc
export LD=${CROSS}-ld
export AS=${CROSS}-as

build_one