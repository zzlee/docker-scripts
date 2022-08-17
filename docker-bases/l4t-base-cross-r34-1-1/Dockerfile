FROM ubuntu:20.04 AS builder

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y software-properties-common bash-completion build-essential git vim wget cpio tcl

# CMake
RUN apt-get install -y libssl-dev libncurses-dev
RUN cd /tmp && git clone https://github.com/Kitware/CMake.git && \
	cd CMake && git checkout v3.22.3 -b build-branch && \
	./configure && make && make install

# NASM
RUN apt-get install -y libtool
RUN cd /tmp && wget https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz && \
	tar xvf nasm-2.15.05.tar.gz && cd nasm-2.15.05 && \
	./autogen.sh && ./configure && make && make install

# Toolchain
ADD http://qcap-registry:8888/l4t-cross-r34-1-1/aarch64--glibc--stable-final.tar.gz /tmp/
RUN mkdir /opt/l4t/toolchain -p && \
	tar xvf /tmp/aarch64--glibc--stable-final.tar.gz -C /opt/l4t/toolchain

# Root FS
ADD http://qcap-registry:8888/l4t-cross-r34-1-1/Tegra_Linux_Sample-Root-Filesystem_R34.1.1_aarch64.tbz2 /tmp/
RUN mkdir /opt/l4t/rootfs -p && \
	tar xvf /tmp/Tegra_Linux_Sample-Root-Filesystem_R34.1.1_aarch64.tbz2 -C /opt/l4t/rootfs

# CUDA
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/cross-linux-sbsa/3bf863cc.pub && \
	add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/cross-linux-sbsa/ /" && \
	apt-get update && \
	apt-get -y install cuda-cross-sbsa && \
	wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
	mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
	apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
	add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" && \
	apt-get update && \
	apt-get -y install cuda

ADD env-setup /opt/l4t/
ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# RUN ldconfig
# RUN apt-get autoremove -y && apt-get clean

# FROM ubuntu:20.04

# COPY --from=builder /usr /usr
# COPY --from=builder /etc /etc
# COPY --from=builder /opt /opt
# COPY --from=builder /bin /bin
# COPY --from=builder /sbin /sbin
# COPY --from=builder /lib /lib
# COPY --from=builder /lib64 /lib64
# COPY --from=builder /lib32 /lib32
# COPY --from=builder /entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]
