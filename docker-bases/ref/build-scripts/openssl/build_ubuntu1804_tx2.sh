#!/bin/bash

cd /docker/qcap/build-3rdparty/ubuntu1804_tx2/openssl

function build_one
{
    ./Configure linux-aarch64 \
        --prefix=/docker/qcap/3rdparty/ubuntu1804_tx2/ \
        no-shared \
        no-async && \
    make && make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one
