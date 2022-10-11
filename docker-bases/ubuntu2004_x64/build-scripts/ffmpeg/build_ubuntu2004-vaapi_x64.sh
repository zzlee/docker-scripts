#!/bin/bash

export FF_EXTRA_ENCODER=libx264,h264_vaapi,hevc_vaapi
export FF_EXTRA_DECODER=libx264,h264_vaapi,hevc_vaapi
. ./build-scripts/ffmpeg/module_vars.sh

cd ./build-3rdparty/ubuntu2004_x64/ffmpeg-vaapi

function build_one
{
	./configure \
		--prefix=/usr/local/qcap/ffmpeg-vaapi/ \
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
ADDI_CFLAGS="-Ofast -fPIC $EXTRA_CFLAGS -pthread"
ADDI_LDFLAGS="-pthread"
ADDI_LIBS="-lm -ldl"
HWACCELS="--disable-vdpau --disable-xvmc --disable-v4l2_m2m --disable-nvenc --disable-nvdec --disable-cuda --disable-cuvid --enable-hwaccel=h264_vaapi,mjpeg_vaapi,hevc_vaapi"

export PKG_CONFIG_PATH=/usr/local/qcap/lib/pkgconfig
build_one
