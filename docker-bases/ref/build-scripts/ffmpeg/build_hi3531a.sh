#!/bin/bash

cd ./build-3rdparty/hi3531a/ffmpeg
. /etc/profile

SYSROOT=/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target

. ../build-scripts/ffmpeg/module_vars.sh

function build_one
{
    ./configure \
        --prefix=${SYSROOT} \
        --pkg-config=pkg-config \
        --pkg-config-flags=--static \
        --disable-shared \
        --disable-doc \
        --enable-static \
        --enable-libfdk-aac \
        --enable-openssl \
        ${FF_FLAGS} \
        --cross-prefix=arm-hisiv300-linux- \
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

EXTRA_CFLAGS="-mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon -mno-unaligned-access -fno-aggressive-loop-optimizations"
ADDI_CFLAGS="-Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include -pthread"
ADDI_LDFLAGS="-pthread"
ADDI_LIBS="-lm -ldl"

export PKG_CONFIG_PATH=/docker/qcap/3rdparty/hi3531a/lib/pkgconfig
build_one