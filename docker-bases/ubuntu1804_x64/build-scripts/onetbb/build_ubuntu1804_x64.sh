#!/bin/bash

cd ./build-3rdparty/ubuntu1804_x64/onetbb && \
mkdir build -p && cd build && \
cmake .. -DCMAKE_INSTALL_PREFIX:PATH=/usr/local/qcap && \
make -j $(( $(nproc) + 1 )) && \
make install && touch DONE
