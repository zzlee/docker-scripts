#!/bin/bash

cd /docker/qcap/build-3rdparty/rk3566_arm64/fcgi

OLD_PWD=${PWD}
cd /opt/rk3566_host
source ./environment-setup
cd ${OLD_PWD}

export LD_LIBRARY_PATH=/opt/rk3566_host/lib
export PATH=/usr/local/bin:/usr/bin:${PATH}

function build_one
{
    if [ ! -f ./configure ]; then
        ./autogen.sh
    fi

    ./configure \
        --prefix=/docker/qcap/3rdparty/rk3566_arm64/ \
        --disable-shared \
        --enable-static \
        --with-pic \
        --host=arm-linux \
        --build=arm && \
    make && make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="${CXXFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"
export CXXFLAGS="${CFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"

build_one