#!/bin/bash

cd ./build-3rdparty/debian105_x64/fcgi

function build_one
{
	if [ ! -f ./configure ]; then
		./autogen.sh
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
