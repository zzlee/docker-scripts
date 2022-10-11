#!/bin/bash

cd /docker/qcap/build-3rdparty/l4t-cross-r32-5-0/freetype

source /opt/l4t/env-setup

export LD_LIBRARY_PATH=/opt/l4t/rootfs/lib
export PATH=/usr/local/bin:/usr/bin:${PATH}

function build_one
{
    ./autogen.sh && \
    cd builds/unix && ln arm-linux-libtool libtool -fs && cd ../.. && \
    ./configure \
        --prefix=/docker/qcap/3rdparty/l4t-cross-r32-5-0/ \
        --disable-shared \
        --enable-static \
        --with-pic \
        --host=arm-linux \
        --with-zlib=no \
        --with-png=no \
        --with-bzip2=no \
        --with-harfbuzz=no && \
    make && make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="${CFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"
export CXXFLAGS="${CXXFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"

build_one