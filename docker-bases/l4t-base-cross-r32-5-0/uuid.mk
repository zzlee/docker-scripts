AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/uuid
	${AT} cd build-3rdparty/uuid && \
	aclocal && autoconf && autoheader && libtoolize && automake -a && \
	. /opt/l4t/env-setup && \
	export CFLAGS="$${CFLAGS} -fPIC -O3 -L$${SDKTARGETSYSROOT}/usr/lib/aarch64-linux-gnu" && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC -O3 -L$${SDKTARGETSYSROOT}/usr/lib/aarch64-linux-gnu" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--enable-static \
	--disable-shared \
	--host=aarch64-linux-gnu && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/uuid:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	git clone https://git.code.sf.net/u/rboehne/libuuid uuid && \
	cd uuid && \
	git checkout libuuid-1.0.3 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/uuid && \
	. /opt/l4t/env-setup && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/uuid -fr