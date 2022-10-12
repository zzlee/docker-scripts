#!/bin/bash

cd ./build-3rdparty/ubuntu1804_x64/fdk-aac

function build_one
{
	if [ ! -f ./configure ]; then
		libtoolize && ./autogen.sh
	fi

	./configure \
		--prefix=/usr/local/qcap \
		--disable-shared \
		--enable-static \
		--with-pic && \
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

build_one