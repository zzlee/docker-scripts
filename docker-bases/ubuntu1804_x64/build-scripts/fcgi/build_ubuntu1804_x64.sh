#!/bin/bash

cd ./build-3rdparty/ubuntu1804_x64/fcgi

function build_one
{
    if [ ! -f ./configure ]; then
        ./autogen.sh
    fi

    ./configure \
        --disable-shared \
        --enable-static \
        --with-pic && \
    make -j $(( $(nproc) + 1 )) && \
    make install && touch DONE
}

build_one