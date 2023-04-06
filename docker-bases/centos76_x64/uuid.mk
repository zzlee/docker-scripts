AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/uuid
	${AT} cd build-3rdparty/uuid && \
	aclocal && autoconf && autoheader && libtoolize && automake -a && \
	export CFLAGS="$${CFLAGS} -fPIC -O3" && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC -O3" && \
	./configure \
	--prefix=/usr/local/qcap \
	--enable-static \
	--disable-shared && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/uuid:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	GIT_SSL_NO_VERIFY=true git clone https://git.code.sf.net/u/rboehne/libuuid uuid && \
	cd uuid && \
	git checkout libuuid-1.0.3 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/uuid && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/uuid -fr