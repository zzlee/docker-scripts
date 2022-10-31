AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/fcgi/configure
	${AT} cd build-3rdparty/fcgi && \
	. /opt/hisi-linux/env-setup && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC" && \
	export CFLAGS="$${CFLAGS} -fPIC" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--disable-shared \
	--enable-static \
	--with-pic \
	--host=arm-linux \
	--build=arm && \
	make -j $$(( $$(nproc) + 1 ))

build-3rdparty/fcgi:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://github.com/FastCGI-Archives/fcgi2.git fcgi && \
	cd fcgi && \
	git checkout 2.4.2 -b build-branch

build-3rdparty/fcgi/configure: build-3rdparty/fcgi
	${AT} cd build-3rdparty/fcgi && \
	if [ ! -f ./configure ]; then ./autogen.sh; fi

.PHONY: install
install:
	${AT} cd build-3rdparty/fcgi && \
	. /opt/hisi-linux/env-setup && \
	make install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/fcgi -fr