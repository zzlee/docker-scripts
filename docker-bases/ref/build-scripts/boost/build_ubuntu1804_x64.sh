#!/bin/bash

cd /docker/qcap/build-3rdparty/ubuntu1804_x64/boost

if [ ! -f ./b2 ]; then
	./bootstrap.sh
fi

function build_one
{
	echo "using gcc ;" > tools/build/src/user-config.jam
	./b2 \
		--with-system \
		--with-thread \
		--with-atomic \
		--with-chrono \
		--with-context \
		--with-filesystem \
		--with-program_options \
		--with-coroutine \
		--prefix=/docker/qcap/3rdparty/ubuntu1804_x64/ \
		variant=release \
		link=static \
		cxxflags="-fPIC $EXTRA_CFLAGS" \
		cflags="-fPIC $EXTRA_CFLAGS" \
		address-model=64 \
		install && touch DONE
}

EXTRA_CFLAGS=""
build_one
