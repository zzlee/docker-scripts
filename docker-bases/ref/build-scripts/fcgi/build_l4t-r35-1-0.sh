#!/bin/bash

cd /docker/qcap/build-3rdparty/l4t-r35-1-0/fcgi

function build_one
{
    if [ ! -f ./configure ]; then
        ./autogen.sh
    fi

    ./configure \
        --prefix=/docker/qcap/3rdparty/l4t-r35-1-0/ \
        --disable-shared \
        --enable-static \
        --with-pic && \
    make && make install && touch DONE
}

build_one