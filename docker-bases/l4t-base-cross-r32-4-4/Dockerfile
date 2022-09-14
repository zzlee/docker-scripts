FROM qcap-registry:5000/l4t-base:r32.4.4 AS l4t_base

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
build-essential git vim wget cpio tcl python

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
./configure && make && make install

# NASM
RUN apt-get install -y libtool && \
cd /tmp && wget https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz && \
tar xvf nasm-2.15.05.tar.gz && cd nasm-2.15.05 && \
./autogen.sh && ./configure && make && make install

# Toolchain
ADD http://qcap-registry:8888/l4t-cross-r32-4-4/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz /tmp/
RUN mkdir /opt/l4t/ -p && \
tar xvf /tmp/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu.tar.xz -C /opt/l4t/ && \
mv /opt/l4t/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu /opt/l4t/toolchain

ADD env-setup /opt/l4t/
ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN ldconfig
RUN apt-get autoremove -y && apt-get clean
