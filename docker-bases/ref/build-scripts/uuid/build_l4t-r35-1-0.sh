#!/bin/bash

cd /docker/qcap/build-3rdparty/l4t-r35-1-0/uuid

function build_one
{
    aclocal && autoconf && autoheader && libtoolize && automake -a && \
    ./configure \
        --prefix=/docker/qcap/3rdparty/l4t-r35-1-0/ \
        --enable-static \
        --disable-shared && \
    make && make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one
