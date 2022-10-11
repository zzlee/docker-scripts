#!/bin/bash

cd /docker/qcap/build-3rdparty/l4t-cross-r35-1-0/iconv

source /opt/l4t/env-setup

export LD_LIBRARY_PATH=/opt/l4t/rootfs/lib
export PATH=/usr/local/bin:/usr/bin:${PATH}

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/l4t-cross-r35-1-0/ \
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