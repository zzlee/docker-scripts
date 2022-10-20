#!/bin/bash

cd ./build-3rdparty/hi3559a210/openssl
. /etc/profile

SYSROOT=/opt/hisi-linux/x86-arm/aarch64-himix210-linux/target

function build_one
{
	./Configure linux-aarch64 \
		--prefix=${SYSROOT}/usr/local/qcap \
		no-shared \
		no-async && \
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
export CXXFLAGS="--sysroot=$SYSROOT -Ofast -fPIC $EXTRA_CFLAGS -I$SYSROOT/usr/include"
PREFIX=aarch64-himix210-linux
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
