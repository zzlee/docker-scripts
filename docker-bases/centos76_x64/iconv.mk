AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/iconv
	${AT} cd build-3rdparty/iconv && \
	export CFLAGS="$${CFLAGS} -O3 -fPIC" && \
	export CXXFLAGS="$${CXXFLAGS} -O3 -fPIC" && \
	./configure \
	--prefix=/usr/local/qcap \
	--disable-shared \
	--enable-static && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/iconv:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	GIT_SSL_NO_VERIFY=true git clone https://github.com/zzlee/libiconv.git iconv

.PHONY: install
install:
	${AT} cd build-3rdparty/iconv && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/iconv -fr