#!/bin/bash

export FF_EXTRA_ENCODER=libx264,h264_nvenc,hevc_nvenc
export FF_EXTRA_DECODER=libx264,h264_nvenc,hevc_nvenc
. ./build-scripts/ffmpeg/module_vars.sh

cd ./build-3rdparty/ubuntu1604_x64/ffmpeg-cuda
export PATH=${PATH}:/usr/local/cuda/bin/

function build_one
{
	./configure \
		--prefix=/usr/local/qcap/ffmpeg-cuda/ \
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
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

EXTRA_CFLAGS=""
ADDI_CFLAGS="-Ofast -fPIC $EXTRA_CFLAGS -I/usr/local/cuda/include -pthread"
ADDI_LDFLAGS="-L/usr/local/cuda/lib64 -pthread"
ADDI_LIBS="-lm -ldl"
HWACCELS="--enable-cuda-nvcc --enable-cuvid --enable-nvenc --enable-libnpp"

export PKG_CONFIG_PATH=/usr/local/qcap/lib/pkgconfig
build_one
