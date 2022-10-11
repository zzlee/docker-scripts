#!/bin/bash

cd ./build-3rdparty/ubuntu1804_x64/iconv

function build_one
{
	./configure \
		--enable-static \
		--disable-shared && \
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one