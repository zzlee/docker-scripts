AT?=@

define boost_build
	${AT} cd build-3rdparty/boost && \
	. /opt/l4t/env-setup && \
	echo "using gcc : custom : $${CROSS_COMPILE}g++ ;" > tools/build/src/user-config.jam && \
	./b2 \
	--with-system \
	--with-thread \
	--with-atomic \
	--with-chrono \
	--with-context \
	--with-filesystem \
	--with-program_options \
	--with-coroutine \
	--prefix=$${SDKTARGETSYSROOT}/usr/local/qcap \
	-j $$(( $$(nproc) + 1 )) \
	toolset=gcc-custom \
	variant=release \
	link=static \
	cxxflags="-fPIC $${CXXFLAGS}" \
	cflags="-fPIC $${CFLAGS}" \
	architecture=arm \
	binary-format=elf \
	abi=aapcs \
	address-model=64
endef

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/boost/b2
	$(call boost_build)

.PHONY: install
install:
	$(call boost_build) install

build-3rdparty/boost:
	${AT} mkdir -p build-3rdparty/ && \
	cd build-3rdparty/ && \
	git clone https://github.com/boostorg/boost.git && \
	cd boost && \
	git checkout boost-1.69.0 -b build-branch && \
	git submodule init && \
	git submodule update

build-3rdparty/boost/b2: build-3rdparty/boost
	${AT} cd build-3rdparty/boost && \
	if [ ! -f ./b2 ]; then ./bootstrap.sh; fi

.PHONY: clean
clean:
	${AT} rm build-3rdparty/boost -fr
