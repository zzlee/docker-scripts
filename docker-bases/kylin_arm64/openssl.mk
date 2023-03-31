AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/openssl
	${AT} cd build-3rdparty/openssl && \
	unset CROSS_COMPILE && \
	export CFLAGS="$${CFLAGS} -fPIC -O3" && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC -O3" && \
    ./Configure linux-aarch64 \
	--prefix=/usr/local/qcap \
	no-shared \
	no-async && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/openssl:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	git clone https://github.com/openssl/openssl.git && \
	cd openssl && \
	git checkout OpenSSL_1_1_1 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/openssl && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/openssl -fr