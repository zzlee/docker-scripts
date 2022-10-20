#!/bin/bash

cd ./build-3rdparty/hi3559a/boost
. /etc/profile

if [ ! -f ./b2 ]; then
	./bootstrap.sh
fi

SYSROOT=/opt/hisi-linux/x86-arm/aarch64-himix100-linux/target

function build_one
{
	echo "using gcc : hi3559a : aarch64-himix100-linux-g++ ;" > tools/build/src/user-config.jam
	./b2 \
		--with-system \
		--with-thread \
		--with-atomic \
		--with-chrono \
		--with-context \
		--with-filesystem \
		--with-program_options \
		--with-coroutine \
		--prefix=${SYSROOT}/usr/local/qcap \
		-j $(( $(nproc) + 1 )) \
		toolset=gcc-hi3559a \
		variant=release \
		link=static \
		cxxflags="-fPIC $EXTRA_CFLAGS" \
		cflags="-fPIC $EXTRA_CFLAGS" \
		architecture=arm \
		address-model=64 \
		binary-format=elf \
		abi=aapcs \
		install && touch DONE
}

EXTRA_CFLAGS=""
build_one
