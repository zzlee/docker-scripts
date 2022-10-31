AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/harfbuzz
	${AT} cd build-3rdparty/harfbuzz && \
	./autogen.sh && \
	. /opt/hisi-linux/env-setup && \
	export CXXFLAGS="$${CXXFLAGS} -fPIC" && \
	export CFLAGS="$${CFLAGS} -fPIC" && \
	./configure \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	--enable-static \
	--host=arm-linux \
	--with-glib=no \
	--with-icu=no \
	--with-freetype=yes \
	FREETYPE_LIBS="-L$${SDKTARGETSYSROOT}/usr/local/qcap/lib -lfreetype" \
	FREETYPE_CFLAGS="-I$${SDKTARGETSYSROOT}/usr/local/qcap/include/freetype2" && \
	make -j $$(( $$(nproc) + 1 ))

build-3rdparty/harfbuzz:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://github.com/harfbuzz/harfbuzz.git && \
	cd harfbuzz && \
	git checkout 2.9.1 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/harfbuzz && \
	. /opt/hisi-linux/env-setup && \
	make install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/harfbuzz -fr