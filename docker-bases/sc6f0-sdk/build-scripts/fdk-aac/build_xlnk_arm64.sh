#!/bin/bash

cd ./build-3rdparty/xlnk_arm64/fdk-aac

source /opt/sc6f0/environment-setup-aarch64-xilinx-linux

function build_one
{
	if [ ! -f ./configure ]; then
		./autogen.sh
	fi

	./configure \
		--prefix=${SDKTARGETSYSROOT}/usr/local/qcap \
		--disable-shared \
		--enable-static \
		--with-pic \
		--host=arm-linux \
		--build=arm && \
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

EXTRA_CFLAGS=""
export CFLAGS="${CFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"
export CXXFLAGS="${CXXFLAGS} -Ofast -fPIC $EXTRA_CFLAGS"

build_one