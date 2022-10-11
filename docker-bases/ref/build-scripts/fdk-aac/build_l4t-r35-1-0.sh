#!/bin/bash

cd /docker/qcap/build-3rdparty/l4t-r35-1-0/fdk-aac

function build_one
{
    if [ ! -f ./configure ]; then
        libtoolize && ./autogen.sh
    fi

    ./configure \
        --prefix=/docker/qcap/3rdparty/l4t-r35-1-0/ \
        --disable-shared \
        --enable-static \
        --with-pic && \
    make && make install && touch DONE
}

build_one