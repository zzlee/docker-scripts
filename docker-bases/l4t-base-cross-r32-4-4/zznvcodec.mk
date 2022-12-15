AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/zznvcodec
	${AT} . /opt/l4t/env-setup && \
	export TARGET_ROOTFS=$${SDKTARGETSYSROOT} && \
	cd build-3rdparty/zznvcodec/samples/15_zznvcodec && \
	make -j $$(( $$(nproc) + 1 ))

build-3rdparty/zznvcodec:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	git clone https://github.com/zzlee/tegra_multimedia_api.git zznvcodec && \
	cd zznvcodec && \
	git checkout r32.5.0

.PHONY: install
install:
	${AT} . /opt/l4t/env-setup && \
	cd build-3rdparty/zznvcodec && \
	mkdir -p $${SDKTARGETSYSROOT}/usr/local/qcap/lib \
	$${SDKTARGETSYSROOT}/usr/local/qcap/include \
	$${SDKTARGETSYSROOT}/usr/local/qcap/bin && \
	cp -f samples/15_zznvcodec/*.so \
	$${SDKTARGETSYSROOT}/usr/local/qcap/lib && \
	cp -f samples/15_zznvcodec/zznvcodec.h \
	$${SDKTARGETSYSROOT}/usr/local/qcap/include && \
	cp -f samples/15_zznvcodec/test_zznvdec \
	samples/15_zznvcodec/test_zznvenc \
	$${SDKTARGETSYSROOT}/usr/local/qcap/bin

.PHONY: clean
clean:
	${AT} rm build-3rdparty/zznvcodec -fr
