#!/bin/bash

cd ./build-3rdparty/hi3531a/boost
. /etc/profile

SYSROOT=/opt/hisi-linux/x86-arm/arm-hisiv300-linux/target

if [ ! -f ./b2 ]; then
	./bootstrap.sh
fi

function build_one
{
	echo "using gcc : hi3531a : arm-hisiv300-linux-g++ ;" > tools/build/src/user-config.jam
	./b2 \
		--with-system \
		--with-thread \
		--with-atomic \
		--with-chrono \
		--with-context \
		--with-filesystem \
		--with-program_options \
		--with-coroutine \
		--prefix=${SYSROOT} \
		toolset=gcc-hi3531a \
		variant=release \
		link=static \
		cxxflags="-fPIC $EXTRA_CFLAGS" \
		cflags="-fPIC $EXTRA_CFLAGS" \
		architecture=arm \
		address-model=32 \
		binary-format=elf \
		abi=aapcs \
		install && touch DONE
}

EXTRA_CFLAGS="-mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon -mno-unaligned-access -fno-aggressive-loop-optimizations"
build_one
