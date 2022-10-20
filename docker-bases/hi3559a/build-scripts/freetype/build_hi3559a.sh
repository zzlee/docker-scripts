#!/bin/bash

cd ./build-3rdparty/hi3559a/freetype
. /etc/profile

SYSROOT=/opt/hisi-linux/x86-arm/aarch64-himix100-linux/target

function build_one
{
	./autogen.sh

	./configure \
		--prefix=${SYSROOT}/usr/local/qcap \
		--disable-shared \
		--enable-static \
		--with-pic \
		--host=arm-linux \
		--build=arm \
		--with-zlib=no \
		--with-png=no \
		--with-harfbuzz=no && \
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
export CXXFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
PREFIX=aarch64-himix100-linux
export LDFLAGS="-lgcc"
export AR=${PREFIX}-ar
export AS=${PREFIX}-gcc
export CC=${PREFIX}-gcc
export CXX=${PREFIX}-g++
export LD=${PREFIX}-ld
export NM=${PREFIX}-nm
export RANLIB=${PREFIX}-ranlib
export STRIP=${PREFIX}-strip

build_one