#!/bin/bash

cd /docker/qcap/build-3rdparty/debian105_x64/yuv

PREFIX=/docker/qcap/3rdparty/debian105_x64

function build_one
{
    make -f ./linux.mk && \
    cp libyuv.a ${PREFIX}/lib -a && \
    cp include/* ${PREFIX}/include -r && \
    touch DONE
}

export CFLAGS="-O2 -fomit-frame-pointer -fPIC"
export CXXFLAGS="-O2 -fomit-frame-pointer -fPIC"

build_one