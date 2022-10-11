#!/bin/bash

cd /docker/qcap/build-3rdparty/ubuntu1804_tx2/fdk-aac

function build_one
{
    if [ ! -f ./configure ]; then
        libtoolize && ./autogen.sh
    fi

    ./configure \
        --prefix=/docker/qcap/3rdparty/ubuntu1804_tx2/ \
        --disable-shared \
        --enable-static \
        --with-pic && \
    make && make install && touch DONE
}

build_one