AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/ffmpeg
	${AT} cd build-3rdparty/ffmpeg && \
	. /opt/hisi-linux/env-setup && \
	export PKG_CONFIG_PATH=$${SDKTARGETSYSROOT}/usr/local/qcap/lib/pkgconfig:$${PKG_CONFIG_PATH} && \
	export FF_EXTRA_ENCODER=libx264 && \
	export FF_EXTRA_DECODER=libx264 && \
	. /tmp/module_vars.sh && \
	export CFLAGS="$${CFLAGS} -fPIC -O3" && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC -O3" && \
	export LDFLAGS="$${LDFLAGS} -pthread -lm -ldl" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--pkg-config=pkg-config \
	--pkg-config-flags=--static \
	--disable-shared \
	--disable-doc \
	--disable-debug \
	--enable-static \
	--enable-libfdk-aac \
	--enable-openssl \
	$${FF_FLAGS} \
	--cross-prefix=$${CROSS_COMPILE} \
	--target-os=linux \
	--arch=arm \
	--enable-gpl \
	--enable-nonfree \
	--enable-neon \
	--enable-asm \
	--enable-pic \
	--enable-cross-compile \
	--sysroot=$${SDKTARGETSYSROOT} \
	--disable-debug && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/ffmpeg:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	git clone https://github.com/FFmpeg/FFmpeg.git ffmpeg && \
	cd ffmpeg && \
	git checkout n5.0 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/ffmpeg && \
	. /opt/hisi-linux/env-setup && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/ffmpeg -fr
