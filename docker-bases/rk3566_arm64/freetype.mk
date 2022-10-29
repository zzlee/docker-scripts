SHELL=/bin/bash
AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/freetype
	${AT} cd build-3rdparty/freetype && \
	if [ ! -f ./configure ]; then ./autogen.sh; fi && \
	export _PWD=`pwd` && \
	cd /opt/rk3566_host && \
	. ./environment-setup && \
	cd $${_PWD} && \
	export CFLAGS="$${CFLAGS} -O3 -fPIC" && \
	export CXXFLAGS="$${CXXFLAGS} -O3 -fPIC" && \
	./autogen.sh && \
	cd builds/unix && ln arm-linux-libtool libtool -fs && \
	cd ../.. && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--disable-shared \
	--enable-static \
	--with-pic \
	--host=arm-linux \
	--with-zlib=no \
	--with-png=no \
	--with-bzip2=no \
	--with-harfbuzz=no && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

.PHONY: install
install:
	${AT} cd build-3rdparty/freetype && \
	export _PWD=`pwd` && \
	cd /opt/rk3566_host && \
	. ./environment-setup && \
	cd $${_PWD} && \
	${MAKE} install

build-3rdparty/freetype:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://github.com/freetype/freetype.git && \
	cd freetype && \
	git checkout VER-2-11-1 -b build-branch && \
	git submodule init && \
	git submodule update

.PHONY: clean
clean:
	${AT} rm build-3rdparty/freetype -fr
