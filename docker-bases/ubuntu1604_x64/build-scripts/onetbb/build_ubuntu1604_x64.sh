#!/bin/bash

cd ./build-3rdparty/ubuntu1604_x64/onetbb && \
mkdir build -p && cd build && \
cmake .. -DCMAKE_CXX_FLAGS=-DTBB_ALLOCATOR_TRAITS_BROKEN && \
make -j $(( $(nproc) + 1 )) && \
make DESTDIR=/usr/local/qcap install && touch DONE