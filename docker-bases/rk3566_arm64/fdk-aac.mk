SHELL=/bin/bash
AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/fdk-aac
	${AT} cd build-3rdparty/fdk-aac && \
	if [ ! -f ./configure ]; then ./autogen.sh; fi && \
	export _PWD=`pwd` && \
	cd /opt/rk3566_host && \
	. ./environment-setup && \
	cd $${_PWD} && \
	export CFLAGS="$${CFLAGS} -O3 -fPIC" && \
	export CXXFLAGS="$${CXXFLAGS} -O3 -fPIC" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--disable-shared \
	--enable-static \
	--with-pic \
	--host=arm-linux \
	--build=arm && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

.PHONY: install
install:
	${AT} cd build-3rdparty/fdk-aac && \
	export _PWD=`pwd` && \
	cd /opt/rk3566_host && \
	. ./environment-setup && \
	cd $${_PWD} && \
	${MAKE} install

build-3rdparty/fdk-aac:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://github.com/mstorsjo/fdk-aac.git && \
	cd fdk-aac && \
	git checkout v2.0.2 -b build-branch

.PHONY: clean
clean:
	${AT} rm build-3rdparty/fdk-aac -fr
