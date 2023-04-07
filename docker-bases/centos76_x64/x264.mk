AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/x264
	${AT} cd build-3rdparty/x264 && \
	export CFLAGS="$${CFLAGS} -O3" && \
	export CXXFLAGS="$${CXXFLAGS} -O3" && \
	./configure \
	--prefix=/usr/local/qcap \
	--disable-asm \
	--enable-static \
	--enable-pic && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/x264:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	GIT_SSL_NO_VERIFY=true git clone https://code.videolan.org/videolan/x264.git && \
	cd x264 && \
	git checkout stable

.PHONY: install
install:
	${AT} cd build-3rdparty/x264 && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/x264 -fr