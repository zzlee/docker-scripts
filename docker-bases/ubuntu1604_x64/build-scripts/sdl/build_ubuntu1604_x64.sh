#!/bin/bash

cd ./build-3rdparty/ubuntu1604_x64/sdl

function build_one
{
	./configure \
		--prefix=/usr/local/qcap \
		--disable-shared \
		--enable-static \
		--with-pic \
		--enable-video-x11 \
		--disable-video-wayland \
		--disable-sndio \
		--disable-sndio-shared && \
	make -j $(( $(nproc) + 1 )) && \
	make install && touch DONE
}

export CFLAGS="-O3 -fPIC"
export CXXFLAGS="-O3 -fPIC"

build_one
