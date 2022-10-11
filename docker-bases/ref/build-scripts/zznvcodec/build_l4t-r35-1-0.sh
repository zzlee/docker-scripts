#!/bin/sh

DIST=/docker/qcap/3rdparty/l4t-r35-1-0

export PATH=/usr/local/cuda/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export LD_LIBRARY_PATH=/usr/local/cuda/targets/aarch64-linux/lib:

cd /docker/qcap/build-3rdparty/l4t-r35-1-0/zznvcodec && \
make && \
mkdir -p ${DIST}/lib ${DIST}/include ${DIST}/bin && \
cp -f samples/15_zznvcodec/*.so ${DIST}/lib && \
cp -f samples/15_zznvcodec/zznvcodec.h ${DIST}/include && \
cp -f samples/15_zznvcodec/test_zznvdec samples/15_zznvcodec/test_zznvenc ${DIST}/bin && \
touch DONE
