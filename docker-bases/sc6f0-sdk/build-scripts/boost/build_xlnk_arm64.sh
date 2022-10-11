#!/bin/bash

cd ./build-3rdparty/xlnk_arm64/boost

if [ ! -f ./b2 ]; then
	./bootstrap.sh
fi

source /opt/sc6f0/environment-setup-aarch64-xilinx-linux

function build_one
{
	echo "using gcc : xlnk_arm64 : ${CXX} ;" > tools/build/src/user-config.jam
	./b2 \
		--with-system \
		--with-thread \
		--with-atomic \
		--with-chrono \
		--with-context \
		--with-filesystem \
		--with-program_options \
		--with-coroutine \
		--prefix=${SDKTARGETSYSROOT}/usr/local/qcap \
		-j $(( $(nproc) + 1 )) \
		toolset=gcc-xlnk_arm64 \
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
