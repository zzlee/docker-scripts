#!/bin/bash

cd /docker/qcap/build-3rdparty/ubuntu2004_x64/freetype

function build_one
{
    ./autogen.sh

    ./configure \
        --prefix=/docker/qcap/3rdparty/ubuntu2004_x64/ \
        --disable-shared \
        --enable-static \
        --with-pic \
        --with-zlib=no \
        --with-png=no \
        --with-harfbuzz=no && \
    make && make install && touch DONE
}

build_one