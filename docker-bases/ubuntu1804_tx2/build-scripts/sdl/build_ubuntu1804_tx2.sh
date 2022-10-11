#!/bin/bash

cd /docker/qcap/build-3rdparty/ubuntu1804_tx2/sdl

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/ubuntu1804_tx2/ \
        --disable-shared \
        --enable-static \
        --with-pic \
        --enable-video-x11 \
        --disable-video-wayland \
        --disable-sndio \
        --disable-sndio-shared && \
    make && make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one
