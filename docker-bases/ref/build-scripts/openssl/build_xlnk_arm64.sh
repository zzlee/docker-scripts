#!/bin/bash

cd /docker/qcap/build-3rdparty/xlnk_arm64/openssl

source /opt/sc6f0/environment-setup-aarch64-xilinx-linux
export PATH=/usr/bin:/usr/local/bin:${PATH}
unset CROSS_COMPILE

function build_one
{
    ./Configure linux-aarch64 \
        --prefix=/docker/qcap/3rdparty/xlnk_arm64/ \
        no-shared \
        no-async && \
    perl configdata.pm --dump && \
    make && make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="${CFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"
export CXXFLAGS="${CXXFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"

build_one
