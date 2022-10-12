#!/bin/bash

cd ./build-3rdparty/ubuntu1804_x64/onetbb && \
mkdir build && cd build && cmake .. && \
make -j $(( $(nproc) + 1 )) && \
make DESTDIR=/usr/local/qcap install && touch DONE