AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/iconv
	${AT} cd build-3rdparty/iconv && \
	. /opt/hisi-linux/env-setup && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC" && \
	export CFLAGS="$${CFLAGS} -fPIC" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--enable-static \
	--disable-shared \
	--host=arm-linux && \
	make -j $$(( $$(nproc) + 1 ))

build-3rdparty/iconv:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://github.com/zzlee/libiconv.git iconv

.PHONY: install
install:
	${AT} cd build-3rdparty/iconv && \
	. /opt/hisi-linux/env-setup && \
	make install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/iconv -fr