FROM yuan88yuan/l4t-base:r34.1.1 AS l4t_base

FROM ubuntu:20.04 AS builder

# Jetson L4T Root FS
COPY --from=l4t_base /usr /opt/l4t/rootfs/usr
COPY --from=l4t_base /etc /opt/l4t/rootfs/etc
COPY --from=l4t_base /opt /opt/l4t/rootfs/opt
COPY --from=l4t_base /bin /opt/l4t/rootfs/bin
COPY --from=l4t_base /sbin /opt/l4t/rootfs/sbin
COPY --from=l4t_base /lib /opt/l4t/rootfs/lib

# Symbolic links
ADD http://qcap-registry:8888/relink.sh /opt/l4t/
RUN chmod +x /opt/l4t/relink.sh
RUN find /opt/l4t/rootfs/etc -type l -exec /opt/l4t/relink.sh {} \;
RUN find /opt/l4t/rootfs/usr/local -type l -exec /opt/l4t/relink.sh {} \;
RUN find /opt/l4t/rootfs/usr/lib -type l -exec /opt/l4t/relink.sh {} \;
RUN find /opt/l4t/rootfs/usr/bin -type l -exec /opt/l4t/relink.sh {} \;
RUN find /opt/l4t/rootfs/usr/sbin -type l -exec /opt/l4t/relink.sh {} \;
RUN find /opt/l4t/rootfs/usr/include -type l -exec /opt/l4t/relink.sh {} \;
RUN cd /opt/l4t/rootfs/usr/lib && \
ln -sf aarch64-linux-gnu/crt1.o crt1.o && \
ln -sf aarch64-linux-gnu/crti.o crti.o && \
ln -sf aarch64-linux-gnu/crtn.o crtn.o

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && \
apt-get install -y software-properties-common bash-completion \
build-essential git vim wget cpio tcl python pkg-config

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" && \
apt-get update && \
apt-get -y install cuda-nvcc-11-4

# CMake
RUN apt-get install -y libssl-dev libncurses-dev && \
cd /tmp && git clone https://github.com/Kitware/CMake.git && \
cd CMake && git checkout v3.22.3 -b build-branch && \
./configure && make -j $(( $(nproc) + 1 )) && make install

# NASM
RUN apt-get install -y libtool && \
cd /tmp && wget https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz && \
tar xvf nasm-2.15.05.tar.gz && cd nasm-2.15.05 && \
./autogen.sh && ./configure && \
make -j $(( $(nproc) + 1 )) && make install

# Toolchain
ADD http://qcap-registry:8888/l4t-cross-r34-1/aarch64--glibc--stable-final.tar.gz /tmp/
RUN mkdir /opt/l4t/toolchain -p && \
tar xvf /tmp/aarch64--glibc--stable-final.tar.gz -C /opt/l4t/toolchain

ADD env-setup /opt/l4t/

# build 3rdparty libs
ADD zznvcodec.mk /tmp
RUN cd /tmp && make -f zznvcodec.mk
ADD boost.mk /tmp
RUN cd /tmp && make -f boost.mk
ADD fdk-aac.mk /tmp
RUN cd /tmp && make -f fdk-aac.mk
ADD x264.mk /tmp
RUN cd /tmp && make -f x264.mk
ADD zlib.mk /tmp
RUN cd /tmp && make -f zlib.mk
ADD openssl.mk /tmp
RUN cd /tmp && make -f openssl.mk
ADD freetype.mk /tmp
RUN cd /tmp && make -f freetype.mk
ADD iconv.mk /tmp
RUN cd /tmp && make -f iconv.mk
ADD uuid.mk /tmp
RUN cd /tmp && make -f uuid.mk
ADD sdl.mk /tmp
RUN cd /tmp && make -f sdl.mk
ADD module_vars.sh /tmp
ADD ffmpeg.mk /tmp
RUN cd /tmp && make -f ffmpeg.mk
ADD fcgi.mk /tmp
RUN cd /tmp && make -f fcgi.mk

ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN ldconfig
RUN apt-get autoremove -y && apt-get clean

FROM ubuntu:20.04

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt /opt
COPY --from=builder /bin /bin
COPY --from=builder /sbin /sbin
COPY --from=builder /lib /lib
COPY --from=builder /lib64 /lib64
COPY --from=builder /lib32 /lib32
COPY --from=builder /libx32 /libx32
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
