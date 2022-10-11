#!/bin/bash

cd ./build-3rdparty/ubuntu2004_x64/boost

if [ ! -f ./b2 ]; then
	./bootstrap.sh
fi

function build_one
{
	echo "using gcc ;" > tools/build/src/user-config.jam
	./b2 \
		--prefix=/usr/local/qcap \
		--with-system \
		--with-thread \
		--with-atomic \
		--with-chrono \
		--with-context \
		--with-filesystem \
		--with-program_options \
		--with-coroutine \
		-j $(( $(nproc) + 1 )) \
		variant=release \
		link=static \
		cxxflags="-fPIC $EXTRA_CFLAGS" \
		cflags="-fPIC $EXTRA_CFLAGS" \
		address-model=64 \
		install && touch DONE
}

EXTRA_CFLAGS=""
build_one
