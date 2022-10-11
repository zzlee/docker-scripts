#!/bin/bash

cd /docker/qcap/build-3rdparty/l4t-cross-r32-5-0/x264

source /opt/l4t/env-setup

export LD_LIBRARY_PATH=/opt/l4t/rootfs/lib
export PATH=/usr/local/bin:/usr/bin:${PATH}

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/l4t-cross-r32-5-0/ \
        --enable-static \
        --disable-opencl \
        --disable-asm \
        --enable-pic \
        --host=arm-linux \
        --cross-prefix=${CROSS_COMPILE} && \
    make && make install && touch DONE
}

export CFLAGS="${CFLAGS} -O3 -fPIC"
export CXXFLAGS="${CXXFLAGS} -O3 -fPIC"

build_one
