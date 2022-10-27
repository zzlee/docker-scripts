SHELL=/bin/bash
AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/uuid
	${AT} cd build-3rdparty/uuid && \
    aclocal && autoconf && autoheader && libtoolize && automake -a && \
	export _PWD=`pwd` && \
	cd /opt/rk3566_host && \
	. ./environment-setup && \
	cd $${_PWD} && \
	export CFLAGS="${CFLAGS} -O3 -fPIC" && \
	export CXXFLAGS="${CXXFLAGS} -O3 -fPIC" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--disable-shared \
	--enable-static \
	--with-pic \
	--host=arm-linux && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

.PHONY: install
install:
	${AT} cd build-3rdparty/uuid && \
	export _PWD=`pwd` && \
	cd /opt/rk3566_host && \
	. ./environment-setup && \
	cd $${_PWD} && \
	${MAKE} install

build-3rdparty/uuid:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://git.code.sf.net/u/rboehne/libuuid uuid && \
	cd uuid && \
	git checkout libuuid-1.0.3 -b build-branch

.PHONY: clean
clean:
	${AT} rm build-3rdparty/uuid -fr
