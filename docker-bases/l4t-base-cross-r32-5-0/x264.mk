AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/x264
	${AT} cd build-3rdparty/x264 && \
	. /opt/l4t/env-setup && \
	export CFLAGS="$${CFLAGS} -O3" && \
	export CXXFLAGS="$${CXXFLAGS} -O3" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--disable-asm \
	--enable-static \
	--enable-pic \
	--host=aarch64-linux-gnu && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/x264:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	git clone https://code.videolan.org/videolan/x264.git && \
	cd x264 && \
	git checkout stable

.PHONY: install
install:
	${AT} cd build-3rdparty/x264 && \
	. /opt/l4t/env-setup && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/x264 -fr