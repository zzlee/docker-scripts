#!/bin/bash

cd ./build-3rdparty/hi3559a/alsa
. /etc/profile

SYSROOT=/opt/hisi-linux/x86-arm/aarch64-himix100-linux/target
EXTRA_CFLAGS="--sysroot=${SYSROOT} -I${SYSROOT}/usr/include -I${SYSROOT}/usr/local/qcap/include"
EXTRA_LDFLAGS="-L${SYSROOT}/usr/lib -L${SYSROOT}/usr/local/qcap/lib"
PREFIX=aarch64-himix100-linux

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

libtoolize --force --copy --automake && \
aclocal && \
autoheader && \
automake --foreign --copy --add-missing && \
autoconf && \
./configure \
--prefix=${SYSROOT}/usr/local/qcap \
--host=aarch64-himix100-linux \
--enable-static --disable-shared && \
make -j $(( $(nproc) + 1 )) && \
make install && touch DONE
