#!/bin/bash

cd /docker/build-3rdparty/hi3519a/boost

if [ ! -f ./b2 ]; then
	./bootstrap.sh
fi

function build_one
{
	echo "using gcc : hi3519a : arm-himix200-linux-g++ ;" > tools/build/src/user-config.jam
	./b2 \
		--with-system \
		--with-thread \
		--with-atomic \
		--with-chrono \
		--with-context \
		--with-filesystem \
		--with-program_options \
		--with-coroutine \
		--prefix=/docker/3rdparty/hi3519a/ \
		toolset=gcc-hi3519a \
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

EXTRA_CFLAGS=""
build_one
