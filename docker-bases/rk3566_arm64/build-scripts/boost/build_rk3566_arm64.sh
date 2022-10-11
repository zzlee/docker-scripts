#!/bin/bash

cd /docker/qcap/build-3rdparty/rk3566_arm64/boost

if [ ! -f ./b2 ]; then
	./bootstrap.sh
fi

OLD_PWD=${PWD}
cd /opt/rk3566_host
source ./environment-setup
cd ${OLD_PWD}

export LD_LIBRARY_PATH=/opt/rk3566_host/lib

function build_one
{
	echo "using gcc : rk3566_arm64 : ${CXX} ;" > tools/build/src/user-config.jam
	./b2 \
		--with-system \
		--with-thread \
		--with-atomic \
		--with-chrono \
		--with-context \
		--with-filesystem \
		--with-program_options \
		--with-coroutine \
		--prefix=/docker/qcap/3rdparty/rk3566_arm64/ \
		toolset=gcc-rk3566_arm64 \
		variant=release \
		link=static \
		cxxflags="-fPIC $EXTRA_CFLAGS ${CXXFLAGS}" \
		cflags="-fPIC $EXTRA_CFLAGS ${CFLAGS}" \
		architecture=arm \
		address-model=64 \
		binary-format=elf \
		abi=aapcs \
		install && touch DONE
}

EXTRA_CFLAGS=""
build_one
