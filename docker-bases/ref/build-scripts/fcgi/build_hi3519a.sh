#!/bin/bash

cd /docker/qcap/build-3rdparty/hi3519a/fcgi

SYSROOT=/opt/hisi-linux/x86-arm/arm-himix200-linux/target

function build_one
{
    if [ ! -f ./configure ]; then
        ./autogen.sh
    fi

    ./configure \
        --prefix=/docker/qcap/3rdparty/hi3519a/ \
        --disable-shared \
        --enable-static \
        --with-pic \
        --host=arm-linux \
        --build=arm && \
    make && make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
export CXXFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
PREFIX=arm-himix200-linux
export LDFLAGS="-lgcc -lm"
export AR=${PREFIX}-ar
export AS=${PREFIX}-gcc
export CC=${PREFIX}-gcc
export CXX=${PREFIX}-g++
export LD=${PREFIX}-ld
export NM=${PREFIX}-nm
export RANLIB=${PREFIX}-ranlib
export STRIP=${PREFIX}-strip

build_one