#!/bin/bash

export FF_EXTRA_ENCODER=libx264
export FF_EXTRA_DECODER=libx264
. /docker/qcap/build-3rdparty-scripts/ffmpeg/module_vars.sh

cd /docker/qcap/build-3rdparty/ubuntu1804_tx2/ffmpeg

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/ubuntu1804_tx2/ \
        --pkg-config=pkg-config \
        --pkg-config-flags=--static \
        --disable-shared \
        --disable-doc \
        --enable-static \
        --enable-libfdk-aac \
        --enable-openssl \
        --enable-libx264 \
        ${FF_FLAGS} \
        --target-os=linux \
        --arch=aarch64 \
        --enable-gpl \
        --enable-nonfree \
        --enable-neon \
        --enable-asm \
        --enable-pic \
        --disable-debug \
        --extra-cflags="$ADDI_CFLAGS" \
        --extra-ldflags="$ADDI_LDFLAGS" \
        --extra-libs="$ADDI_LIBS" \
        $ADDITIONAL_CONFIGURE_FLAG && \
    make && make install && touch DONE
}

EXTRA_CFLAGS=""
ADDI_CFLAGS="-Ofast -fPIC $EXTRA_CFLAGS -pthread"
ADDI_LDFLAGS="-pthread"
ADDI_LIBS="-lm -ldl"

export PKG_CONFIG_PATH=/docker/qcap/3rdparty/ubuntu1804_tx2/lib/pkgconfig
build_one
