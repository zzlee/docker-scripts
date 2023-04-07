AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/fdk-aac
	${AT} cd build-3rdparty/fdk-aac && \
	if [ ! -f ./configure ]; then libtoolize && ./autogen.sh; fi && \
	./configure \
	--prefix=/usr/local/qcap \
	--disable-shared \
	--enable-static \
	--with-pic && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/fdk-aac:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	GIT_SSL_NO_VERIFY=true git clone https://github.com/mstorsjo/fdk-aac.git && \
	cd fdk-aac && \
	git checkout v2.0.2 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/fdk-aac && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/fdk-aac -fr