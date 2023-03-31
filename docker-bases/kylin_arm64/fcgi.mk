AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/fcgi
	${AT} cd build-3rdparty/fcgi && \
    if [ ! -f ./configure ]; then ./autogen.sh; fi && \
	export CFLAGS="$${CFLAGS} -fPIC -O3" && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC -O3" && \
	./configure \
	--prefix=/usr/local/qcap \
	--disable-shared \
	--enable-static \
	--with-pic && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/fcgi:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	GIT_SSL_NO_VERIFY=true git clone https://github.com/FastCGI-Archives/fcgi2.git fcgi && \
	cd fcgi && \
	git checkout 2.4.2 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/fcgi && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/fcgi -fr