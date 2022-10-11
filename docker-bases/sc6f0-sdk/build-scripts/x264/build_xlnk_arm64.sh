#!/bin/bash

cd ./build-3rdparty/xlnk_arm64/x264

source /opt/sc6f0/environment-setup-aarch64-xilinx-linux

function build_one
{
	./configure \
		--prefix=${SDKTARGETSYSROOT}/usr/local/qcap \
		--enable-static \
		--disable-opencl \
		--disable-asm \
		--enable-pic \
		--host=arm-linux \
		--cross-prefix=${CROSS_COMPILE} \
		--sysroot=${SDKTARGETSYSROOT} && \
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

export CFLAGS="${CFLAGS} -O3 -fPIC"
export CXXFLAGS="${CXXFLAGS} -O3 -fPIC"

build_one
