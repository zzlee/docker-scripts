#!/bin/bash

cd /docker/qcap/build-3rdparty/rk3566_arm64/uuid

OLD_PWD=${PWD}
cd /opt/rk3566_host
source ./environment-setup
cd ${OLD_PWD}

export LD_LIBRARY_PATH=/opt/rk3566_host/lib
export PATH=/usr/local/bin:/usr/bin:${PATH}

function build_one
{
    aclocal && autoconf && autoheader && libtoolize && automake -a && \
    ./configure \
        --prefix=/docker/qcap/3rdparty/rk3566_arm64/ \
        --enable-static \
        --disable-shared \
        --host=$CROSS && \
    make && make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="${CFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"
export CXXFLAGS="${CXXFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"
export CROSS=aarch64-xilinx-linux

build_one
