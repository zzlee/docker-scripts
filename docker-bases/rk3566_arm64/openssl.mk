SHELL=/bin/bash
AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/openssl
	${AT} cd build-3rdparty/openssl && \
	export _PWD=`pwd` && \
	cd /opt/rk3566_host && \
	. ./environment-setup && \
	cd $${_PWD} && \
	unset CROSS_COMPILE && \
	export CFLAGS="${CFLAGS} -O3 -fPIC" && \
	export CXXFLAGS="${CXXFLAGS} -O3 -fPIC" && \
	./Configure linux-aarch64 \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	no-shared \
	no-async && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

.PHONY: install
install:
	${AT} cd build-3rdparty/openssl && \
	export _PWD=`pwd` && \
	cd /opt/rk3566_host && \
	. ./environment-setup && \
	cd $${_PWD} && \
	${MAKE} install

build-3rdparty/openssl:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://github.com/openssl/openssl.git && \
	cd openssl && \
	git checkout OpenSSL_1_1_1 -b build-branch

.PHONY: clean
clean:
	${AT} rm build-3rdparty/openssl -fr
