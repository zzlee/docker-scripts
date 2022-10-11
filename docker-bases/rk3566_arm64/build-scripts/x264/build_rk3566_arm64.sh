#!/bin/bash

cd /docker/qcap/build-3rdparty/rk3566_arm64/x264

OLD_PWD=${PWD}
cd /opt/rk3566_host
source ./environment-setup
cd ${OLD_PWD}

export LD_LIBRARY_PATH=/opt/rk3566_host/lib
export PATH=/usr/local/bin:/usr/bin:${PATH}

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/rk3566_arm64/ \
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
