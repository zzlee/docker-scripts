#!/bin/bash

PLATFORM=arm-hisiv500-linux

SYSROOT=/opt/hisi-linux/x86-arm/${PLATFORM}/target/usr/local/qcap

tar -zcvf /docker/alsa-lib.tar.gz \
${SYSROOT}/include/alsa \
${SYSROOT}/include/asoundlib.h \
${SYSROOT}/lib/libasound.a \
${SYSROOT}/lib/libasound.la \
${SYSROOT}/lib/libatopology.a \
${SYSROOT}/lib/libatopology.la \
${SYSROOT}/lib/pkgconfig/alsa.pc \
${SYSROOT}/lib/pkgconfig/alsa-topology.pc \
${SYSROOT}/lib/pkgconfig \
${SYSROOT}/lib/libasound.la \
${SYSROOT}/share/aclocal/alsa.m4 \
${SYSROOT}/share/alsa \
${SYSROOT}/bin/aserver 


