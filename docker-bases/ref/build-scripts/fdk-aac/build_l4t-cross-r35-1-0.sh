#!/bin/bash

cd /docker/qcap/build-3rdparty/l4t-cross-r35-1-0/fdk-aac

source /opt/l4t/env-setup

export LD_LIBRARY_PATH=/opt/l4t/rootfs/lib
export PATH=/usr/local/bin:/usr/bin:${PATH}

function build_one
{
    if [ ! -f ./configure ]; then
        libtoolize && ./autogen.sh
    fi

    ./configure \
        --prefix=/docker/qcap/3rdparty/l4t-cross-r35-1-0/ \
        --disable-shared \
        --enable-static \
        --with-pic \
        --host=arm-linux \
        --build=arm && \
    make && make install && touch DONE
}

build_one