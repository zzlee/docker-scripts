#!/bin/bash

cd /docker/qcap/build-3rdparty/hi3559a/iconv

SYSROOT=/opt/hisi-linux/x86-arm/aarch64-himix100-linux/target

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/hi3559a/ \
        --enable-static \
        --disable-shared \
        --host=$CROSS && \
    make && make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
export CXXFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
export TARGETMACH=aarch64-himix100-linux
export BUILDMACH=i686-pc-linux-gnu
export CROSS=aarch64-himix100-linux
export CC=${CROSS}-gcc
export LD=${CROSS}-ld
export AS=${CROSS}-as

build_one