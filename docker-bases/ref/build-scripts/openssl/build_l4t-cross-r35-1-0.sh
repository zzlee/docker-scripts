#!/bin/bash

cd /docker/qcap/build-3rdparty/l4t-cross-r35-1-0/openssl

source /opt/l4t/env-setup

export LD_LIBRARY_PATH=/opt/l4t/rootfs/lib
export PATH=/usr/local/bin:/usr/bin:${PATH}
unset CROSS_COMPILE

function build_one
{
    ./Configure linux-aarch64 \
        --prefix=/docker/qcap/3rdparty/l4t-cross-r35-1-0/ \
        no-shared \
        no-async && \
    perl configdata.pm --dump && \
    make && make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="${CFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"
export CXXFLAGS="${CXXFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"

build_one
