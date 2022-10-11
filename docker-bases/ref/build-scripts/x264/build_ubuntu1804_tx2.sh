#!/bin/bash

cd /docker/qcap/build-3rdparty/ubuntu1804_tx2/x264

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/ubuntu1804_tx2/ \
        --enable-static \
        --enable-pic && \
    make && make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one
