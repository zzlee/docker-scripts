FROM ubuntu:18.04 AS builder

ENV DEBIAN_FRONTEND noninteractive
RUN	apt-get -y update && apt-get -y install	\
	autoconf \
	automake \
	autopoint \
	bash \
	bison \
	bzip2 \
	flex \
	gettext \
	git \
	g++ \
	gperf \
	intltool \
	libffi-dev \
	libgdk-pixbuf2.0-dev \
	libtool \
	libltdl-dev \
	libssl-dev \
	libxml-parser-perl \
	make \
	openssl \
	p7zip-full \
	patch \
	perl \
	pkg-config \
	python3 \
	ruby \
	scons \
	sed \
	unzip \
	wget \
	xz-utils \
	g++-multilib \
	libc6-dev-i386 \
	libtool-bin \
	lzip \
	llvm

RUN groupadd -r mxe && useradd -r -g mxe mxe && mkdir /opt/mxe && chown mxe:mxe /opt/mxe
USER mxe

# CMake
# RUN cd /tmp && git clone https://github.com/Kitware/CMake.git && \
# 	cd CMake && git checkout v3.22.3 -b build-branch && \
# 	./configure && make && make install

# MXE
RUN cd /opt && git clone https://github.com/mxe/mxe.git && \
cd mxe && git checkout build-2021-01-10 -b build-branch

RUN cd /opt/mxe && make -j 4 \
yasm \
x264 \
x265 \
fdk-aac \
openssl \
opus \
lame \
sdl2 \
curl \
boost \
MXE_USE_CCACHE= \
MXE_TARGETS="x86_64-w64-mingw32.static i686-w64-mingw32.static"

# FFmpeg
RUN cd /tmp && git clone https://github.com/FFmpeg/FFmpeg.git ffmpeg_x64 && \
	cd ffmpeg_x64 && \
	git checkout n5.0 -b build-branch
ADD build_ffmpeg_x64.sh /tmp/ffmpeg_x64
RUN cd /tmp/ffmpeg_x64 && ./build_ffmpeg_x64.sh

RUN cd /tmp && git clone https://github.com/FFmpeg/FFmpeg.git ffmpeg_x86 && \
	cd ffmpeg_x86 && \
	git checkout n5.0 -b build-branch
ADD build_ffmpeg_x86.sh /tmp/ffmpeg_x86
RUN cd /tmp/ffmpeg_x86 && ./build_ffmpeg_x86.sh

USER root

ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get autoremove -y && apt-get clean

FROM ubuntu:18.04

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt/mxe/usr /opt/mxe/usr
COPY --from=builder /bin /bin
COPY --from=builder /sbin /sbin
COPY --from=builder /lib /lib
COPY --from=builder /lib64 /lib64
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
