#!/bin/bash

cd /docker/qcap/build-3rdparty/hi3559a/uuid

SYSROOT=/opt/hisi-linux/x86-arm/aarch64-himix100-linux/target

function build_one
{
    aclocal && autoconf && autoheader && libtoolize && automake -a && \
    ./configure \
        --prefix=/docker/qcap/3rdparty/hi3559a/ \
        --enable-static \
        --disable-shared \
        --host=$CROSS && \
    make && make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="-Ofast -fPIC $EXTRA_CFLAGS"
export CXXFLAGS="-Ofast -fPIC $EXTRA_CFLAGS"
export TARGETMACH=aarch64-himix100-linux
export BUILDMACH=i686-pc-linux-gnu
export CROSS=aarch64-himix100-linux
export CC=${CROSS}-gcc
export LD=${CROSS}-ld
export AS=${CROSS}-as

build_one
