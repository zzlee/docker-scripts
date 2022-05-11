#!/bin/sh

MXE_PATH=/opt/mxe
ARCH=x86_64
TARGET=x86_64-w64-mingw32.static
INSTALL_PATH="${MXE_PATH}/usr/${TARGET}"
CROSS_PREFIX="${TARGET}-"

echo MXE_PATH=${MXE_PATH}
echo INSTALL_PATH=${INSTALL_PATH}
echo CROSS_PREFIX=${CROSS_PREFIX}

export PATH=${PATH}:${MXE_PATH}/usr/bin/
./configure --cross-prefix=$CROSS_PREFIX \
	--enable-cross-compile \
	--arch=$ARCH \
	--target-os=mingw32 \
	--prefix=$INSTALL_PATH \
	--yasmexe=${CROSS_PREFIX}yasm \
	--enable-static \
	--disable-shared \
	--disable-pthreads \
	--enable-w32threads \
	--disable-doc \
	--enable-asm \
	--enable-pic \
	--disable-debug \
	--enable-libfdk-aac \
	--enable-libmp3lame \
	--enable-openssl \
	--disable-mediafoundation && \
make -j 4 && make install
