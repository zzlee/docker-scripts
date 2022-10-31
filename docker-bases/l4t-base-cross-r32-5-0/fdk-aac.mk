AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/fdk-aac
	${AT} cd build-3rdparty/fdk-aac && \
	if [ ! -f ./configure ]; then libtoolize && ./autogen.sh; fi && \
	. /opt/l4t/env-setup && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--disable-shared \
	--enable-static \
	--with-pic \
	--host=aarch64-buildroot-linux-gnu && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/fdk-aac:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	git clone https://github.com/mstorsjo/fdk-aac.git && \
	cd fdk-aac && \
	git checkout v2.0.2 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/fdk-aac && \
	. /opt/l4t/env-setup && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/fdk-aac -fr