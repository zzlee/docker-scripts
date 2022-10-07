#!/bin/bash

cd /docker/qcap/build-3rdparty/hi3559a210/zlib

SYSROOT=/opt/hisi-linux/x86-arm/aarch64-himix210-linux/target

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/hi3559a210/ \
        --static && \
    make && make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
export CXXFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
# export INSTALLDIR=$_PWD/aarch64-himix210-linux
# export PATH=$INSTALLDIR/bin:$PATH
export TARGETMACH=aarch64-himix210-linux
export BUILDMACH=i686-pc-linux-gnu
export CROSS=aarch64-himix210-linux
export CC=${CROSS}-gcc
export LD=${CROSS}-ld
export AS=${CROSS}-as

build_one