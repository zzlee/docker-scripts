#!/bin/bash

cd /docker/qcap/build-3rdparty/ubuntu1604_x64/openssl

function build_one
{
    ./Configure linux-x86_64 \
        --prefix=/docker/qcap/3rdparty/ubuntu1604_x64/ \
        no-shared \
        no-async && \
    make && make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one
