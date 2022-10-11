#!/bin/bash

export FF_EXTRA_ENCODER=libx264
export FF_EXTRA_DECODER=libx264
cd ./build-3rdparty/xlnk_arm64/ffmpeg
. ../../../build-scripts/ffmpeg/module_vars.sh

source /opt/sc6f0/environment-setup-aarch64-xilinx-linux
unset PKG_CONFIG_SYSROOT_DIR

function build_one
{
	./configure \
		--prefix=${SDKTARGETSYSROOT}/usr/local/qcap \
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
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

EXTRA_CFLAGS=""
ADDI_CFLAGS="-Ofast -fPIC $EXTRA_CFLAGS -pthread"
ADDI_LDFLAGS="-pthread"
ADDI_LIBS="-lm -ldl"

export PKG_CONFIG_PATH=${SDKTARGETSYSROOT}/usr/local/qcap/lib/pkgconfig
build_one