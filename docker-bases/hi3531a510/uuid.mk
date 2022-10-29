AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/uuid/configure
	${AT} cd build-3rdparty/uuid && \
	. /opt/hisi-linux/env-setup && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC" && \
	export CFLAGS="$${CFLAGS} -fPIC" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--enable-static \
	--disable-shared \
	--host=arm-linux && \
	make -j $$(( $$(nproc) + 1 ))

build-3rdparty/uuid:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://git.code.sf.net/u/rboehne/libuuid uuid && \
	cd uuid && \
	git checkout libuuid-1.0.3 -b build-branch

build-3rdparty/uuid/configure: build-3rdparty/uuid
	${AT} cd build-3rdparty/uuid && \
	if [ ! -f ./configure ]; then aclocal && autoconf && autoheader && libtoolize && automake -a; fi

.PHONY: install
install:
	${AT} cd build-3rdparty/uuid && \
	. /opt/hisi-linux/env-setup && \
	make install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/uuid -fr