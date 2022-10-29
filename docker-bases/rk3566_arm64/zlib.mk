SHELL=/bin/bash
AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/zlib
	${AT} cd build-3rdparty/zlib && \
	if [ ! -f ./configure ]; then ./autogen.sh; fi && \
	export _PWD=`pwd` && \
	cd /opt/rk3566_host && \
	. ./environment-setup && \
	cd $${_PWD} && \
	export CFLAGS="$${CFLAGS} -O3 -fPIC" && \
	export CXXFLAGS="$${CXXFLAGS} -O3 -fPIC" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--static && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

.PHONY: install
install:
	${AT} cd build-3rdparty/zlib && \
	export _PWD=`pwd` && \
	cd /opt/rk3566_host && \
	. ./environment-setup && \
	cd $${_PWD} && \
	${MAKE} install

build-3rdparty/zlib:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://github.com/madler/zlib.git && \
	cd zlib && \
	git checkout v1.2.11 -b build-branch

.PHONY: clean
clean:
	${AT} rm build-3rdparty/zlib -fr
