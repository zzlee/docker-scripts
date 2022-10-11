#!/bin/bash

cd /docker/qcap/build-3rdparty/l4t-cross-r32-5-0/boost

if [ ! -f ./b2 ]; then
	./bootstrap.sh
fi

source /opt/l4t/env-setup

function build_one
{
	echo "using gcc : custom : ${CXX} ;" > tools/build/src/user-config.jam
	./b2 \
		--with-system \
		--with-thread \
		--with-atomic \
		--with-chrono \
		--with-context \
		--with-filesystem \
		--with-program_options \
		--with-coroutine \
		--prefix=/docker/qcap/3rdparty/l4t-cross-r32-5-0/ \
		toolset=gcc-custom \
		variant=release \
		link=static \
		cxxflags="-fPIC $EXTRA_CFLAGS ${CXXFLAGS}" \
		cflags="-fPIC $EXTRA_CFLAGS ${CFLAGS}" \
		architecture=arm \
		address-model=64 \
		binary-format=elf \
		abi=aapcs \
		install && touch DONE
}

EXTRA_CFLAGS=""
build_one
