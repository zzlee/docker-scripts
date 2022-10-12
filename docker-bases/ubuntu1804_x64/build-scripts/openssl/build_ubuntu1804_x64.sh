#!/bin/bash

cd ./build-3rdparty/ubuntu1804_x64/openssl

function build_one
{
	./Configure linux-x86_64 \
		--prefix=/usr/local/qcap \
		no-shared \
		no-async && \
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one
