PLATFORM:=hi3531a400

.PHONY: install-3rdparty
install-3rdparty: \
	build-3rdparty/${PLATFORM}/boost/DONE \
	build-3rdparty/${PLATFORM}/fdk-aac/DONE \
	build-3rdparty/${PLATFORM}/zlib/DONE \
	build-3rdparty/${PLATFORM}/openssl/DONE \
	build-3rdparty/${PLATFORM}/freetype/DONE \
	build-3rdparty/${PLATFORM}/iconv/DONE \
	build-3rdparty/${PLATFORM}/uuid/DONE \
	build-3rdparty/${PLATFORM}/ffmpeg/DONE \
	build-3rdparty/${PLATFORM}/fcgi/DONE \
	install-3rdparty_prebuilt

.PHONY: clean-3rdparty
clean-3rdparty:
	@rm -rf build-3rdparty/${PLATFORM}

#################################################################################
## prebuilt

.PHONY: install-3rdparty_prebuilt
install-3rdparty_prebuilt:
	@cp prebuilt-3rdparty/${PLATFORM} 3rdparty/ -arf

#################################################################################
## boost

clean-3rdparty_${PLATFORM}_boost:
	@rm -rf build-3rdparty/${PLATFORM}/boost

build-3rdparty/${PLATFORM}/boost:
	@mkdir -p build-3rdparty/${PLATFORM} && \
		cd build-3rdparty/${PLATFORM}/ && \
		git clone https://github.com/boostorg/boost.git && \
		cd boost && \
		git checkout boost-1.69.0 -b build-branch && \
		git submodule init && \
		git submodule update

build-3rdparty/${PLATFORM}/boost/DONE: build-3rdparty/${PLATFORM}/boost
	@echo Building boost...
	${DOCKER_BUILD} ${BUILD_SCRIPT_HOME}/boost/build_${PLATFORM}.sh

#################################################################################
## fdk-aac

clean-3rdparty_${PLATFORM}_fdk-aac:
	@rm -rf build-3rdparty/${PLATFORM}/fdk-aac

build-3rdparty/${PLATFORM}/fdk-aac:
	@mkdir -p build-3rdparty/${PLATFORM} && \
		cd build-3rdparty/${PLATFORM}/ && \
		git clone https://github.com/mstorsjo/fdk-aac.git && \
		cd fdk-aac && \
		git checkout v2.0.2 -b build-branch

build-3rdparty/${PLATFORM}/fdk-aac/DONE: build-3rdparty/${PLATFORM}/fdk-aac
	@echo Building fdk-aac...
	${DOCKER_BUILD} ${BUILD_SCRIPT_HOME}/fdk-aac/build_${PLATFORM}.sh

#################################################################################
## zlib

clean-3rdparty_${PLATFORM}_zlib:
	@rm -rf build-3rdparty/${PLATFORM}/zlib

build-3rdparty/${PLATFORM}/zlib:
	@mkdir -p build-3rdparty/${PLATFORM} && \
		cd build-3rdparty/${PLATFORM}/ && \
		git clone https://github.com/madler/zlib.git && \
		cd zlib && \
		git checkout v1.2.11 -b build-branch

build-3rdparty/${PLATFORM}/zlib/DONE: build-3rdparty/${PLATFORM}/zlib
	@echo Building zlib...
	${DOCKER_BUILD} ${BUILD_SCRIPT_HOME}/zlib/build_${PLATFORM}.sh

#################################################################################
## openssl

clean-3rdparty_${PLATFORM}_openssl:
	@rm -rf build-3rdparty/${PLATFORM}/openssl

build-3rdparty/${PLATFORM}/openssl:
	@mkdir -p build-3rdparty/${PLATFORM} && \
		cd build-3rdparty/${PLATFORM}/ && \
		git clone https://github.com/openssl/openssl.git && \
		cd openssl && \
		git checkout OpenSSL_1_1_1 -b build-branch

build-3rdparty/${PLATFORM}/openssl/DONE: build-3rdparty/${PLATFORM}/openssl
	@echo Building openssl...
	${DOCKER_BUILD} ${BUILD_SCRIPT_HOME}/openssl/build_${PLATFORM}.sh

#################################################################################
## freetype

clean-3rdparty_${PLATFORM}_freetype:
	@rm -rf build-3rdparty/${PLATFORM}/freetype

build-3rdparty/${PLATFORM}/freetype:
	@mkdir -p build-3rdparty/${PLATFORM}/ && \
		cd build-3rdparty/${PLATFORM}/ && \
		git clone https://github.com/freetype/freetype.git && \
		cd freetype && \
		git checkout VER-2-11-1 -b build-branch && \
		git submodule init && \
		git submodule update

build-3rdparty/${PLATFORM}/freetype/DONE: build-3rdparty/${PLATFORM}/freetype
	@echo Building freetype...
	${DOCKER_BUILD} ${BUILD_SCRIPT_HOME}/freetype/build_${PLATFORM}.sh

#################################################################################
## iconv

clean-3rdparty_${PLATFORM}_iconv:
	@rm -rf build-3rdparty/${PLATFORM}/iconv

build-3rdparty/${PLATFORM}/iconv:
	@mkdir -p build-3rdparty/${PLATFORM}/ && \
		cd build-3rdparty/${PLATFORM}/ && \
		git clone https://github.com/zzlee/libiconv.git iconv

build-3rdparty/${PLATFORM}/iconv/DONE: build-3rdparty/${PLATFORM}/iconv
	@echo Building iconv...
	${DOCKER_BUILD} ${BUILD_SCRIPT_HOME}/iconv/build_${PLATFORM}.sh

#################################################################################
## uuid

clean-3rdparty_${PLATFORM}_uuid:
	@rm -rf build-3rdparty/${PLATFORM}/uuid

build-3rdparty/${PLATFORM}/uuid:
	@mkdir -p build-3rdparty/${PLATFORM}/ && \
		cd build-3rdparty/${PLATFORM}/ && \
		git clone https://git.code.sf.net/u/rboehne/libuuid uuid && \
		cd uuid && \
		git checkout libuuid-1.0.3 -b build-branch

build-3rdparty/${PLATFORM}/uuid/DONE: build-3rdparty/${PLATFORM}/uuid
	@echo Building uuid...
	${DOCKER_BUILD} ${BUILD_SCRIPT_HOME}/uuid/build_${PLATFORM}.sh

#################################################################################
## ffmpeg

clean-3rdparty_${PLATFORM}_ffmpeg:
	@rm -rf build-3rdparty/${PLATFORM}/ffmpeg

build-3rdparty/${PLATFORM}/ffmpeg:
	@mkdir -p build-3rdparty/${PLATFORM} && \
		cd build-3rdparty/${PLATFORM}/ && \
		git clone https://github.com/FFmpeg/FFmpeg.git ffmpeg && \
		cd ffmpeg && \
		git checkout n4.4 -b build-branch

build-3rdparty/${PLATFORM}/ffmpeg/DONE: \
	build-3rdparty/${PLATFORM}/ffmpeg \
	build-3rdparty/${PLATFORM}/fdk-aac/DONE \
	build-3rdparty/${PLATFORM}/zlib/DONE \
	build-3rdparty/${PLATFORM}/openssl/DONE \
	build-3rdparty/${PLATFORM}/freetype/DONE \
	build-3rdparty/${PLATFORM}/iconv/DONE \
	build-3rdparty/${PLATFORM}/uuid/DONE
	@echo Building ffmpeg...
	${DOCKER_BUILD} ${BUILD_SCRIPT_HOME}/ffmpeg/build_${PLATFORM}.sh

#################################################################################
## fcgi

clean-3rdparty_${PLATFORM}_fcgi:
	@rm -rf build-3rdparty/${PLATFORM}/fcgi

build-3rdparty/${PLATFORM}/fcgi:
	@mkdir -p build-3rdparty/${PLATFORM}/ && \
		cd build-3rdparty/${PLATFORM}/ && \
		git clone https://github.com/FastCGI-Archives/fcgi2.git fcgi && \
		cd fcgi && \
		git checkout 2.4.2 -b build-branch

build-3rdparty/${PLATFORM}/fcgi/DONE: build-3rdparty/${PLATFORM}/fcgi
	@echo Building fcgi...
	${DOCKER_BUILD} ${BUILD_SCRIPT_HOME}/fcgi/build_${PLATFORM}.sh
