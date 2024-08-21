FROM ubuntu:22.04 AS builder

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y install \
    autoconf \
    automake \
    autopoint \
    bash \
    bison \
    bzip2 \
    flex \
    g++ \
    g++-multilib \
    gettext \
    git \
    gperf \
    intltool \
    libc6-dev-i386 \
    libgdk-pixbuf2.0-dev \
    libltdl-dev \
    libgl-dev \
    libpcre3-dev \
    libssl-dev \
    libtool-bin \
    libxml-parser-perl \
    lzip \
    make \
    openssl \
    p7zip-full \
    patch \
    perl \
    python3 \
    python3-distutils \
    python3-mako \
    python3-packaging \
    python3-pkg-resources \
    python-is-python3 \
    ruby \
    sed \
    sqlite3 \
    unzip \
    wget \
    xz-utils \
    g++-multilib \
    libc6-dev-i386 \
    cmake \
    scons

RUN groupadd -r mxe && useradd -r -g mxe mxe && mkdir /opt/mxe && chown mxe:mxe /opt/mxe
USER mxe

# MXE
RUN cd /opt && git clone https://github.com/mxe/mxe.git && \
cd mxe && git checkout build-2022-04-09 -b build-branch

RUN cd /opt/mxe && make -j 4 \
yasm \
x264 \
x265 \
fdk-aac \
openssl \
opus \
lame \
curl \
boost \
MXE_USE_CCACHE= \
MXE_TARGETS="x86_64-w64-mingw32.static i686-w64-mingw32.static"

USER root

# FFmpeg
ADD ffmpeg.tar.gz /tmp
ADD build_ffmpeg_x64.sh /tmp/ffmpeg/
ADD build_ffmpeg_x86.sh /tmp/ffmpeg/

RUN cd /tmp/ffmpeg && \
./build_ffmpeg_x64.sh && make clean && \
./build_ffmpeg_x86.sh && make clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# RUN apt-get autoremove -y && apt-get clean

# FROM ubuntu:22.04

# COPY --from=builder /usr /usr
# COPY --from=builder /etc /etc
# COPY --from=builder /opt/mxe/usr /opt/mxe/usr
# COPY --from=builder /bin /bin
# COPY --from=builder /sbin /sbin
# COPY --from=builder /lib /lib
# COPY --from=builder /lib64 /lib64
# COPY --from=builder /entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]
