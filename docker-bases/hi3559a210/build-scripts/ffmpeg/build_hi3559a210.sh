#!/bin/bash

cd ./build-3rdparty/hi3559a210/ffmpeg
. /etc/profile

SYSROOT=/opt/hisi-linux/x86-arm/aarch64-himix210-linux/target

. ../../../build-scripts/ffmpeg/module_vars.sh

function build_one
{
	./configure \
		--prefix=${SYSROOT}/usr/local/qcap \
		--pkg-config=pkg-config \
		--pkg-config-flags=--static \
		--disable-shared \
		--disable-doc \
		--enable-static \
		--enable-libfdk-aac \
		--enable-openssl \
		${FF_FLAGS} \
		--cross-prefix=aarch64-himix210-linux- \
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
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

EXTRA_CFLAGS=""
ADDI_CFLAGS="-Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include -pthread"
ADDI_LDFLAGS="-pthread"
ADDI_LIBS="-lm -ldl"

export PKG_CONFIG_PATH=${SYSROOT}/usr/local/qcap/lib/pkgconfig
build_one