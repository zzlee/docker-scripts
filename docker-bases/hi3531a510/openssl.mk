AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/openssl
	${AT} cd build-3rdparty/openssl && \
	. /opt/hisi-linux/env-setup && \
	unset CROSS_COMPILE && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC" && \
	export CFLAGS="$${CFLAGS} -fPIC" && \
	./Configure linux-armv4 \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	no-shared \
	no-async && \
	make -j $$(( $$(nproc) + 1 ))

build-3rdparty/openssl:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://github.com/openssl/openssl.git && \
	cd openssl && \
	git checkout OpenSSL_1_1_1 -b build-branch

build-3rdparty/openssl/configure: build-3rdparty/openssl
	${AT} cd build-3rdparty/openssl && \
	if [ ! -f ./b2 ]; then ./autogen.sh; fi

.PHONY: install
install:
	${AT} cd build-3rdparty/openssl && \
	. /opt/hisi-linux/env-setup && \
	make install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/openssl -fr