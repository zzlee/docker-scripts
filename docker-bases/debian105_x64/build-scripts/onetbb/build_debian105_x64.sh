#!/bin/bash

cd ./build-3rdparty/debian105_x64/onetbb

mkdir build -p && cd build && \
cmake .. && \
make -j $(( $(nproc) + 1 )) && \
make DESTDIR=/usr/local/qcap install && touch DONE
