#!/bin/bash

cd ./build-3rdparty/ubuntu1804_x64/uuid

function build_one
{
	aclocal && autoconf && autoheader && libtoolize && automake -a && \
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
