SHELL=/bin/bash
AT?=@

define boost_build
	${AT} cd build-3rdparty/boost && \
	export _PWD=`pwd` && \
	cd /opt/rk3566_host && \
	. ./environment-setup && \
	cd $${_PWD} && \
	echo "using gcc : rk3566_arm64 : $${CXX} ;" > tools/build/src/user-config.jam && \
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
	toolset=gcc-rk3566_arm64 \
	variant=release \
	link=static \
	cxxflags="-fPIC ${CXXFLAGS}" \
	cflags="-fPIC ${CFLAGS}" \
	architecture=arm \
	address-model=64 \
	binary-format=elf \
	abi=aapcs
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
