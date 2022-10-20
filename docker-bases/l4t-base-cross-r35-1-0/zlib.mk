AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/zlib
	${AT} cd build-3rdparty/zlib && \
	. /opt/l4t/env-setup && \
	export CFLAGS="$${CFLAGS} -fPIC -O3 -L$${SDKTARGETSYSROOT}/usr/lib/aarch64-linux-gnu" && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC -O3 -L$${SDKTARGETSYSROOT}/usr/lib/aarch64-linux-gnu" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--static && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/zlib:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	git clone https://github.com/madler/zlib.git && \
	cd zlib && \
	git checkout v1.2.11 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/zlib && \
	. /opt/l4t/env-setup && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/zlib -fr