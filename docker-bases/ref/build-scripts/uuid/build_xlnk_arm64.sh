#!/bin/bash

cd /docker/qcap/build-3rdparty/xlnk_arm64/uuid

source /opt/sc6f0/environment-setup-aarch64-xilinx-linux

function build_one
{
    aclocal && autoconf && autoheader && libtoolize && automake -a && \
    ./configure \
        --prefix=/docker/qcap/3rdparty/xlnk_arm64/ \
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
