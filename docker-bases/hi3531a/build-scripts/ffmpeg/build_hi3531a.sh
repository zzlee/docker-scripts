#!/bin/bash

cd ./build-3rdparty/hi3531a/ffmpeg
. /etc/profile

SYSROOT=/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target

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
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

EXTRA_CFLAGS="-mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon -mno-unaligned-access -fno-aggressive-loop-optimizations --sysroot=${SYSROOT} -I${SYSROOT}/usr/include -I${SYSROOT}/usr/local/qcap/include"
EXTRA_LDFLAGS="-L${SYSROOT}/usr/lib -L${SYSROOT}/usr/local/qcap/lib"
PREFIX=arm-hisiv300-linux

export CFLAGS="-Ofast -fPIC ${EXTRA_CFLAGS}"
export CXXFLAGS="-Ofast -fPIC ${EXTRA_CFLAGS}"
export LDFLAGS="${EXTRA_LDFLAGS} -lgcc -pthread -lm -ldl"
export AR=${PREFIX}-ar
export AS=${PREFIX}-gcc
export CC=${PREFIX}-gcc
export CXX=${PREFIX}-g++
export LD=${PREFIX}-ld
export NM=${PREFIX}-nm
export RANLIB=${PREFIX}-ranlib
export STRIP=${PREFIX}-strip

build_one