AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/ffmpeg-cuda
	${AT} cd build-3rdparty/ffmpeg-cuda && \
	export PATH=$${PATH}:/usr/local/cuda/bin/ && \
	export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/local/qcap/lib/pkgconfig:$${PKG_CONFIG_PATH} && \
	export FF_EXTRA_ENCODER=libx264,h264_nvenc,hevc_nvenc && \
	export FF_EXTRA_DECODER=libx264,h264_nvenc,hevc_nvenc && \
	. /tmp/module_vars.sh && \
	export HWACCELS="--enable-cuda-nvcc --enable-cuvid --enable-nvenc --enable-libnpp" && \
	export CFLAGS="$${CFLAGS} -fPIC -O3 -I/usr/local/cuda/include" && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC -O3 -I/usr/local/cuda/include" && \
	export LDFLAGS="$${LDFLAGS} -pthread -lm -ldl -L/usr/local/cuda/lib64" && \
	./configure \
	--prefix=/usr/local/qcap/ffmpeg-cuda/ \
	--pkg-config=pkg-config \
	--pkg-config-flags=--static \
	--disable-shared \
	--disable-doc \
	$${HWACCELS} \
	--enable-static \
	--enable-libfdk-aac \
	--enable-openssl \
	--enable-libx264 \
	$${FF_FLAGS} \
	--target-os=linux \
	--enable-gpl \
	--enable-nonfree \
	--enable-neon \
	--enable-asm \
	--enable-pic \
	--disable-debug && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/ffmpeg-cuda:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	GIT_SSL_NO_VERIFY=true git clone https://github.com/FFmpeg/FFmpeg.git ffmpeg-cuda && \
	cd ffmpeg-cuda && \
	git checkout n5.0 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/ffmpeg-cuda && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/ffmpeg-cuda -fr
