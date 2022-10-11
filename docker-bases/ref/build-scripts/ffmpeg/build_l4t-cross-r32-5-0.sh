#!/bin/bash

export FF_EXTRA_ENCODER=libx264
export FF_EXTRA_DECODER=libx264
. /docker/qcap/build-3rdparty-scripts/ffmpeg/module_vars.sh

cd /docker/qcap/build-3rdparty/l4t-cross-r32-5-0/ffmpeg

source /opt/l4t/env-setup

export LD_LIBRARY_PATH=/opt/l4t/rootfs/lib
export PATH=/usr/local/bin:/usr/bin:${PATH}

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/l4t-cross-r32-5-0/ \
        --pkg-config=pkg-config \
        --pkg-config-flags=--static \
        --disable-shared \
        --disable-doc \
        --enable-static \
        --enable-libfdk-aac \
        --enable-openssl \
        --enable-libx264 \
        ${FF_FLAGS} \
        --cross-prefix=${CROSS_COMPILE} \
        --sysroot=${SDKTARGETSYSROOT} \
        --target-os=linux \
        --arch=aarch64 \
        --enable-gpl \
        --enable-nonfree \
        --enable-neon \
        --enable-asm \
        --enable-pic \
        --enable-cross-compile \
        --disable-debug \
        --extra-cflags="$ADDI_CFLAGS" \
        --extra-ldflags="$ADDI_LDFLAGS" \
        --extra-libs="$ADDI_LIBS" \
        $ADDITIONAL_CONFIGURE_FLAG && \
    make && make install && touch DONE
}

EXTRA_CFLAGS="-I/docker/qcap/3rdparty/l4t-cross-r32-5-0/include"
ADDI_CFLAGS="-Ofast -fPIC $EXTRA_CFLAGS -pthread"
ADDI_LDFLAGS="-pthread -L/docker/qcap/3rdparty/l4t-cross-r32-5-0/lib"
ADDI_LIBS="-lm -ldl"

export PKG_CONFIG_PATH=/docker/qcap/3rdparty/l4t-cross-r32-5-0/lib/pkgconfig
build_one