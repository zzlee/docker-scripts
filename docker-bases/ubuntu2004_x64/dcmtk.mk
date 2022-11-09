AT?=@

.PHONY: all
all: build install

.PHONY: build
build: build-3rdparty/dcmtk
	${AT} cd build-3rdparty/dcmtk && \
	mkdir build -p && cd build && \
	cmake -DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX:PATH=/usr/local/qcap \
	-DCMAKE_POSITION_INDEPENDENT_CODE=ON \
	-DDCMTK_WITH_WRAP:BOOL=FALSE \
	-DDCMTK_ENABLE_BUILTIN_DICTIONARY:BOOL=TRUE .. && \
	${MAKE} -j $$(( $$(nproc) + 1 ))

build-3rdparty/dcmtk:
	${AT} mkdir -p build-3rdparty && \
	cd build-3rdparty/ && \
	git clone https://github.com/DCMTK/dcmtk.git dcmtk && \
	cd dcmtk && \
	git checkout DCMTK-3.6.5 -b build-branch

.PHONY: install
install:
	${AT} cd build-3rdparty/dcmtk/build && \
	${MAKE} install

.PHONY: clean
clean:
	${AT} rm build-3rdparty/dcmtk -fr