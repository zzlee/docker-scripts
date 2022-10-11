#!/bin/bash

DIST=/docker/qcap/3rdparty/l4t-cross-r35-1-0

source /opt/l4t/env-setup && \
export LD_LIBRARY_PATH=/opt/l4t/rootfs/lib && \
export PATH=/usr/local/bin:/usr/bin:${PATH} && \
export TARGET_ROOTFS=${SDKTARGETSYSROOT} && \
cd /docker/qcap/build-3rdparty/l4t-cross-r35-1-0/zznvcodec && \
make && \
mkdir -p ${DIST}/lib ${DIST}/include ${DIST}/bin && \
cp -f samples/15_zznvcodec/*.so ${DIST}/lib && \
cp -f samples/15_zznvcodec/zznvcodec.h ${DIST}/include && \
cp -f samples/15_zznvcodec/test_zznvdec samples/15_zznvcodec/test_zznvenc ${DIST}/bin && \
cp -f samples/80_zppi/*.so ${DIST}/lib && \
cp -f samples/80_zppi/zppi.h ${DIST}/include && \
touch DONE
