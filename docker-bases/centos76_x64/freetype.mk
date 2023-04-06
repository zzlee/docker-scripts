AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/freetype
	${AT} cd build-3rdparty/freetype && \
	./autogen.sh && \
	export CFLAGS="$${CFLAGS} -O3" && \
	export CXXFLAGS="$${CXXFLAGS} -O3" && \
	./configure \
	--prefix=/usr/local/qcap \
	--disable-shared \
	--enable-static \
	--with-pic && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/freetype:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	GIT_SSL_NO_VERIFY=true git clone https://github.com/freetype/freetype.git && \
	cd freetype && \
	git checkout VER-2-11-1 -b build-branch && \
	git submodule init && \
	git submodule update

.PHONY: install
install:
	${AT} cd build-3rdparty/freetype && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/freetype -fr