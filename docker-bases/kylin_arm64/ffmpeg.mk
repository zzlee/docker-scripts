AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/ffmpeg
	${AT} cd build-3rdparty/ffmpeg && \
	export PKG_CONFIG_PATH=/usr/local/qcap/lib/pkgconfig:$${PKG_CONFIG_PATH} && \
	export FF_EXTRA_ENCODER=libx264 && \
	export FF_EXTRA_DECODER=libx264 && \
	. /tmp/module_vars.sh && \
	export CFLAGS="$${CFLAGS} -fPIC -O3" && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC -O3" && \
	export LDFLAGS="$${LDFLAGS} -pthread -lm -ldl" && \
	./configure \
	--prefix=/usr/local/qcap \
	--pkg-config=pkg-config \
	--pkg-config-flags=--static \
	--disable-shared \
	--disable-doc \
	--enable-static \
	--enable-libfdk-aac \
	--enable-openssl \
	--enable-libx264 \
	$${FF_FLAGS} \
	--target-os=linux \
	--arch=aarch64 \
	--enable-gpl \
	--enable-nonfree \
	--enable-neon \
	--enable-asm \
	--enable-pic \
	--disable-debug && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/ffmpeg:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	GIT_SSL_NO_VERIFY=true git clone https://github.com/FFmpeg/FFmpeg.git ffmpeg && \
	cd ffmpeg && \
	git checkout n5.0 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/ffmpeg && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/ffmpeg -fr
