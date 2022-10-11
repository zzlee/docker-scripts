#!/bin/bash

cd /docker/qcap/build-3rdparty/ubuntu1604_x64/fcgi

function build_one
{
    if [ ! -f ./configure ]; then
        ./autogen.sh
    fi

    ./configure \
        --prefix=/docker/qcap/3rdparty/ubuntu1604_x64/ \
        --disable-shared \
        --enable-static \
        --with-pic && \
    make && make install && touch DONE
}

build_one