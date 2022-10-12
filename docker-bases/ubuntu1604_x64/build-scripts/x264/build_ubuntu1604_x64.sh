#!/bin/bash

cd ./build-3rdparty/ubuntu1604_x64/x264

function build_one
{
	./configure \
		--prefix=/usr/local/qcap \
		--enable-static \
		--enable-pic && \
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one
