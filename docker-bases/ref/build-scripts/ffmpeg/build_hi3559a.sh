#!/bin/bash

SYSROOT=/opt/hisi-linux/x86-arm/aarch64-himix100-linux/target

. /docker/qcap/build-3rdparty-scripts/ffmpeg/module_vars.sh

cd /docker/qcap/build-3rdparty/hi3559a/ffmpeg

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/hi3559a/ \
        --pkg-config=pkg-config \
        --pkg-config-flags=--static \
        --disable-shared \
        --disable-doc \
        --enable-static \
        --enable-libfdk-aac \
        --enable-openssl \
        ${FF_FLAGS} \
        --cross-prefix=aarch64-himix100-linux- \
        --target-os=linux \
        --arch=aarch64 \
        --enable-gpl \
        --enable-nonfree \
        --enable-neon \
        --enable-asm \
        --enable-pic \
        --enable-cross-compile \
        --disable-debug \
        --sysroot=$SYSROOT \
        --extra-cflags="$ADDI_CFLAGS" \
        --extra-ldflags="$ADDI_LDFLAGS" \
        --extra-libs="$ADDI_LIBS" \
        $ADDITIONAL_CONFIGURE_FLAG && \
    make && make install && touch DONE
}

EXTRA_CFLAGS=""
ADDI_CFLAGS="-Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include -pthread"
ADDI_LDFLAGS="-pthread"
ADDI_LIBS="-lm -ldl"

export PKG_CONFIG_PATH=/docker/qcap/3rdparty/hi3559a/lib/pkgconfig
build_one