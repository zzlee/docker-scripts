#!/bin/bash

cd ./build-3rdparty/ubuntu1604_x64/yuv

PREFIX=/usr/local/qcap

function build_one
{
	make -f ./linux.mk && -j $(( $(nproc) + 1 )) && \
	cp libyuv.a ${PREFIX}/lib -a && \
	cp include/* ${PREFIX}/include -r && \
	touch DONE
}

export CFLAGS="-O2 -fomit-frame-pointer -fPIC"
export CXXFLAGS="-O2 -fomit-frame-pointer -fPIC"

build_one