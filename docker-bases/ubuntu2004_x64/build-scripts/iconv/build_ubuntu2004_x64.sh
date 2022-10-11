#!/bin/bash

cd ./build-3rdparty/ubuntu2004_x64/iconv

function build_one
{
	./configure \
		--prefix=/usr/local/qcap \
		--enable-static \
		--disable-shared && \
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one