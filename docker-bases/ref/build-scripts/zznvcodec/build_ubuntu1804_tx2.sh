#!/bin/sh

cd /docker/qcap/build-3rdparty/ubuntu1804_tx2/zznvcodec

DIST=/docker/qcap/3rdparty/ubuntu1804_tx2

make && \
mkdir -p ${DIST}/lib ${DIST}/include ${DIST}/bin && \
cp -f samples/15_zznvcodec/*.so ${DIST}/lib && \
cp -f samples/15_zznvcodec/zznvcodec.h ${DIST}/include && \
cp -f samples/15_zznvcodec/test_zznvdec samples/15_zznvcodec/test_zznvenc ${DIST}/bin && \
touch DONE
