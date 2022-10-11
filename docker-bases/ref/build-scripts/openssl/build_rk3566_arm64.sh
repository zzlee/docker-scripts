#!/bin/bash

cd /docker/qcap/build-3rdparty/rk3566_arm64/openssl

OLD_PWD=${PWD}
cd /opt/rk3566_host
source ./environment-setup
cd ${OLD_PWD}

export LD_LIBRARY_PATH=/opt/rk3566_host/lib
unset CROSS_COMPILE
export PATH=/usr/local/bin:/usr/bin:${PATH}

function build_one
{
    ./Configure linux-aarch64 \
        --prefix=/docker/qcap/3rdparty/rk3566_arm64/ \
        no-shared \
        no-async && \
    perl configdata.pm --dump && \
    make && make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="${CFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"
export CXXFLAGS="${CXXFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"

build_one
