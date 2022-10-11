#!/bin/bash

cd ./build-3rdparty/ubuntu2004_x64/onetbb

cmake . -B build &&
cd build &&
make -j $(( $(nproc) + 1 )) && \
make DESTDIR=/usr/local/qcap install && touch DONE
