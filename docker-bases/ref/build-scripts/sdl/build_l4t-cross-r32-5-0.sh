#!/bin/bash

cd /docker/qcap/build-3rdparty/l4t-cross-r32-5-0/sdl

source /opt/l4t/env-setup

# export LD_LIBRARY_PATH=/opt/l4t/rootfs/lib
export PATH=/usr/local/bin:/usr/bin:${PATH}

function build_one
{
    ./configure \
        --host=aarch64-linux \
        --prefix=/docker/qcap/3rdparty/l4t-cross-r32-5-0/ \
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
