#!/bin/bash

cd /docker/qcap/build-3rdparty/xlnk_arm64/freetype

source /opt/sc6f0/environment-setup-aarch64-xilinx-linux

function build_one
{
    ./autogen.sh && \
    cd builds/unix && ln arm-linux-libtool libtool -fs && cd ../.. && \
    ./configure \
        --prefix=/docker/qcap/3rdparty/xlnk_arm64/ \
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