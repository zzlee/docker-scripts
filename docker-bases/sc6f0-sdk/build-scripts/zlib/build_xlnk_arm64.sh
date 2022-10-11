#!/bin/bash

cd ./build-3rdparty/xlnk_arm64/zlib

source /opt/sc6f0/environment-setup-aarch64-xilinx-linux

function build_one
{
	./configure \
		--prefix=${SDKTARGETSYSROOT}/usr/local/qcap \
		--static && \
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="${CFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"
export CXXFLAGS="${CXXFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"

build_one