#!/bin/bash

cd ./build-3rdparty/hi3531d/boost
. /etc/profile

SYSROOT=/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target

if [ ! -f ./b2 ]; then
	./bootstrap.sh
fi

function build_one
{
	echo "using gcc : hi3531d : arm-hisiv500-linux-g++ ;" > tools/build/src/user-config.jam
	./b2 \
		--with-system \
		--with-thread \
		--with-atomic \
		--with-chrono \
		--with-context \
		--with-filesystem \
		--with-program_options \
		--with-coroutine \
		--prefix=${SYSROOT}/usr/local/qcap \
		-j $(( $(nproc) + 1 )) \
		toolset=gcc-hi3531d \
		variant=release \
		link=static \
		cxxflags="${CXXFLAGS}" \
		cflags="${CFLAGS}" \
		architecture=arm \
		address-model=32 \
		binary-format=elf \
		abi=aapcs \
		install && touch DONE
}

EXTRA_CFLAGS="-march=armv7-a -mcpu=cortex-a9 -mfloat-abi=softfp -mfpu=neon -mno-unaligned-access -fno-aggressive-loop-optimizations  --sysroot=${SYSROOT} -I${SYSROOT}/usr/include -I${SYSROOT}/usr/local/qcap/include"
EXTRA_LDFLAGS="-L${SYSROOT}/usr/lib -L${SYSROOT}/usr/local/qcap/lib"
PREFIX=arm-hisiv500-linux

export CFLAGS="-Ofast -fPIC ${EXTRA_CFLAGS}"
export CXXFLAGS="-Ofast -fPIC ${EXTRA_CFLAGS}"
export LDFLAGS="${EXTRA_LDFLAGS} -lgcc"
export AR=${PREFIX}-ar
export AS=${PREFIX}-gcc
export CC=${PREFIX}-gcc
export CXX=${PREFIX}-g++
export LD=${PREFIX}-ld
export NM=${PREFIX}-nm
export RANLIB=${PREFIX}-ranlib
export STRIP=${PREFIX}-strip

build_one
