AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/fdk-aac/configure
	${AT} cd build-3rdparty/fdk-aac && \
	. /opt/hisi-linux/env-setup && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC" && \
	export CFLAGS="$${CFLAGS} -fPIC" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--disable-shared \
	--enable-static \
	--with-pic \
	--host=arm-linux \
	--build=arm && \
	make -j $$(( $$(nproc) + 1 ))

build-3rdparty/fdk-aac:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://github.com/mstorsjo/fdk-aac.git && \
	cd fdk-aac && \
	git checkout v2.0.2 -b build-branch

build-3rdparty/fdk-aac/configure: build-3rdparty/fdk-aac
	${AT} cd build-3rdparty/fdk-aac && \
	if [ ! -f ./configure ]; then ./autogen.sh; fi

.PHONY: install
install:
	${AT} cd build-3rdparty/fdk-aac && \
	. /opt/hisi-linux/env-setup && \
	make install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/fdk-aac -fr