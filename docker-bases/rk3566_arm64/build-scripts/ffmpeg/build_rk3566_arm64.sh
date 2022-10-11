#!/bin/bash

export FF_EXTRA_ENCODER=libx264
export FF_EXTRA_DECODER=libx264
. /docker/qcap/build-3rdparty-scripts/ffmpeg/module_vars.sh

cd /docker/qcap/build-3rdparty/rk3566_arm64/ffmpeg

OLD_PWD=${PWD}
cd /opt/rk3566_host
source ./environment-setup
cd ${OLD_PWD}

export LD_LIBRARY_PATH=/opt/rk3566_host/lib
export PATH=/usr/local/bin:/usr/bin:${PATH}

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/rk3566_arm64/ \
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

EXTRA_CFLAGS=""
ADDI_CFLAGS="-Ofast -fPIC $EXTRA_CFLAGS -pthread"
ADDI_LDFLAGS="-pthread"
ADDI_LIBS="-lm -ldl"

export PKG_CONFIG_PATH=/docker/qcap/3rdparty/rk3566_arm64/lib/pkgconfig
build_one