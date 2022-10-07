#!/bin/bash

cd ./build-3rdparty/hi3531d/alsa
. /etc/profile

SYSROOT=/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target

libtoolize --force --copy --automake && \
aclocal && \
autoheader && \
automake --foreign --copy --add-missing && \
autoconf && \
./configure CC=arm-hisiv500-linux-gcc \
--prefix=${SYSROOT}/usr \
--host=arm-hisiv300-linux \
--enable-static --disable-shared
make -j $(( $(nproc) + 1 )) && \
make install && touch DONE
