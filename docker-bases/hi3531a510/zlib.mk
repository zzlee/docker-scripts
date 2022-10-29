AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/zlib
	${AT} cd build-3rdparty/zlib && \
	. /opt/hisi-linux/env-setup && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC" && \
	export CFLAGS="$${CFLAGS} -fPIC" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--static && \
	make -j $$(( $$(nproc) + 1 ))

build-3rdparty/zlib:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://github.com/madler/zlib.git && \
	cd zlib && \
	git checkout v1.2.11 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/zlib && \
	. /opt/hisi-linux/env-setup && \
	make install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/zlib -fr