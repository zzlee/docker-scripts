AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/freetype
	${AT} cd build-3rdparty/freetype && \
	./autogen.sh && \
	. /opt/hisi-linux/env-setup && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC" && \
	export CFLAGS="$${CFLAGS} -fPIC" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--disable-shared \
	--enable-static \
	--with-pic \
	--host=arm-linux \
	--build=arm \
	--with-zlib=no \
	--with-png=no \
	--with-harfbuzz=no && \
	make -j $$(( $$(nproc) + 1 ))

build-3rdparty/freetype:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://github.com/freetype/freetype.git && \
	cd freetype && \
	git checkout VER-2-11-1 -b build-branch && \
	git submodule init && \
	git submodule update

.PHONY: install
install:
	${AT} cd build-3rdparty/freetype && \
	. /opt/hisi-linux/env-setup && \
	make install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/freetype -fr