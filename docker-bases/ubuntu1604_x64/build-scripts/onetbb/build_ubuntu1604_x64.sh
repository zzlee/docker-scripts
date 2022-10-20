#!/bin/bash

cd ./build-3rdparty/ubuntu1604_x64/onetbb && \
mkdir build -p && cd build && \
cmake .. -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/qcap \
-DCMAKE_CXX_FLAGS=-DTBB_ALLOCATOR_TRAITS_BROKEN && \
make -j $(( $(nproc) + 1 )) && \
make install && touch DONE
