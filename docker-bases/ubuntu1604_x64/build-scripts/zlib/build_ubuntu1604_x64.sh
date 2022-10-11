#!/bin/bash

cd /docker/qcap/build-3rdparty/ubuntu1604_x64/zlib

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/ubuntu1604_x64/ \
        --static && \
    make && make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one