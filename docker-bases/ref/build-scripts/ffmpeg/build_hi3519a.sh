#!/bin/bash

SYSROOT=/opt/hisi-linux/x86-arm/arm-himix200-linux/target

. /docker/qcap/build-3rdparty-scripts/ffmpeg/module_vars.sh

cd /docker/qcap/build-3rdparty/hi3519a/ffmpeg

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/hi3519a/ \
        --pkg-config=pkg-config \
        --pkg-config-flags=--static \
        --disable-shared \
        --disable-doc \
        --enable-static \
        --enable-libfdk-aac \
        --enable-openssl \
        ${FF_FLAGS} \
        --cross-prefix=arm-himix200-linux- \
        --target-os=linux \
        --arch=arm \
        --cpu=armv7-a \
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

export PKG_CONFIG_PATH=/docker/qcap/3rdparty/hi3519a/lib/pkgconfig
build_one