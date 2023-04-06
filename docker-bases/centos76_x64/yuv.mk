AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/yuv
	${AT} cd build-3rdparty/yuv && \
	export CFLAGS="-O2 -fomit-frame-pointer -fPIC" && \
	export CXXFLAGS="-O2 -fomit-frame-pointer -fPIC" && \
	${MAKE} -f ./linux.mk -j $$(( $$(nproc) + 1 ))

build-3rdparty/yuv:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	git clone https://chromium.googlesource.com/libyuv/libyuv yuv && \
	cd yuv && \
	git checkout stable

.PHONY: install
install:
	${AT} cd build-3rdparty/yuv && \
	cp libyuv.a /usr/local/qcap/lib -a && \
	cp include/* /usr/local/qcap/include -r

.PHONY: clean
clean:
	${AT} rm build-3rdparty/yuv -fr