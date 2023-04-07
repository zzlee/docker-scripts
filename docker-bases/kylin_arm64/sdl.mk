AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/sdl
	${AT} cd build-3rdparty/sdl && \
	export CFLAGS="$${CFLAGS} -fPIC -O3" && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC -O3" && \
	./configure \
	--prefix=/usr/local/qcap \
	--disable-shared \
	--enable-static \
	--with-pic \
	--enable-video-x11 \
	--disable-video-wayland \
	--disable-sndio \
	--disable-sndio-shared && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/sdl:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	git clone https://github.com/libsdl-org/SDL.git sdl && \
	cd sdl && \
	git checkout release-2.0.20 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/sdl && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/sdl -fr