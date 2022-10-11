#!/bin/bash

cd /docker/qcap/build-3rdparty/ubuntu1804_tx2/zlib

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/ubuntu1804_tx2/ \
        --static && \
    make && make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one