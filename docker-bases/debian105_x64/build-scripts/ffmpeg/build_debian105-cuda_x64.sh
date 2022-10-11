#!/bin/bash

export FF_EXTRA_ENCODER=libx264
export FF_EXTRA_DECODER=libx264
. /docker/qcap/build-3rdparty-scripts/ffmpeg/module_vars.sh

cd /docker/qcap/build-3rdparty/debian105_x64/ffmpeg-cuda
export PATH=${PATH}:/usr/local/cuda/bin/

function build_one
{
    ./configure \
        --prefix=/docker/qcap/3rdparty/debian105-cuda_x64/ \
        --pkg-config=pkg-config \
        --pkg-config-flags=--static \
        --disable-shared \
        --disable-doc \
        ${HWACCELS} \
        --enable-static \
        --enable-libfdk-aac \
        --enable-openssl \
        --enable-libx264 \
        ${FF_FLAGS} \
        --target-os=linux \
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
ADDI_CFLAGS="-Ofast -fPIC $EXTRA_CFLAGS -I/usr/local/cuda/include -pthread"
ADDI_LDFLAGS="-L/usr/local/cuda/lib64 -pthread"
ADDI_LIBS="-lm -ldl"
HWACCELS="--enable-cuda-nvcc --enable-cuvid --enable-nvenc --enable-libnpp"

export PKG_CONFIG_PATH=/docker/qcap/3rdparty/debian105_x64/lib/pkgconfig
build_one
