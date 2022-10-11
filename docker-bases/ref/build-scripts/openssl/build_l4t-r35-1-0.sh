#!/bin/bash

cd /docker/qcap/build-3rdparty/l4t-r35-1-0/openssl

function build_one
{
    ./Configure linux-aarch64 \
        --prefix=/docker/qcap/3rdparty/l4t-r35-1-0/ \
        no-shared \
        no-async && \
    make && make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one
