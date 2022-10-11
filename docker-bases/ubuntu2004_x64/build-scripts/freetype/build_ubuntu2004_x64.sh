#!/bin/bash

cd ./build-3rdparty/ubuntu2004_x64/freetype

function build_one
{
	./autogen.sh

	./configure \
		--prefix=/usr/local/qcap \
		--disable-shared \
		--enable-static \
		--with-pic \
		--with-zlib=no \
		--with-png=no \
		--with-harfbuzz=no && \
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

build_one