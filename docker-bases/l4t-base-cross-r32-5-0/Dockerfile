FROM nvcr.io/nvidia/l4t-base:r32.5.0 as builder2

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion build-essential git vim wget cpio

# CMake
RUN apt-get install -y libssl-dev libncurses-dev
# RUN cd /tmp && git -c http.sslVerify=false clone https://github.com/Kitware/CMake.git && cd CMake && git checkout v3.22.3 -b build-branch && ./configure && make && make install

# 3rdparty libs
RUN apt-get install -y libasound-dev libfontconfig-dev libgstreamer1.0-dev \
	libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev \
	libgstreamer-plugins-good1.0-dev libx11-dev libxv-dev libv4l-dev

# # CUDA
# ADD http://qcap-registry:8888/cuda/cuda_11.1.0_455.23.05_linux_sbsa.run /tmp
# RUN cd /tmp && chmod +x ./cuda_11.1.0_455.23.05_linux_sbsa.run && \
# ./cuda_11.1.0_455.23.05_linux_sbsa.run --silent --toolkit
# ADD http://qcap-registry:8888/l4t-r32-5-0/tegra.tar.gz /tmp
# RUN tar xvf /tmp/tegra.tar.gz -C /

RUN ldconfig
RUN apt-get autoremove -y && apt-get clean

FROM ubuntu:20.04 AS builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion build-essential git vim wget cpio

# CUDA cross
ADD http://qcap-registry:8888/cuda/cuda-repo-cross-sbsa-ubuntu1804-11-1-local_11.1.0-1_all.deb /tmp
RUN dpkg -i /tmp/cuda-repo-cross-sbsa-ubuntu1804-11-1-local_11.1.0-1_all.deb
RUN apt-key add /var/cuda-repo-cross-sbsa-ubuntu1804-11-1-local/7fa2af80.pub
RUN apt-get update
RUN apt-get -y install cuda-cross-sbsa

# CMake
RUN apt-get install -y libssl-dev libncurses-dev
RUN cd /tmp && git clone https://github.com/Kitware/CMake.git && \
	cd CMake && git checkout v3.22.3 -b build-branch && \
	./configure && make && make install

COPY --from=builder2 /usr /opt/l4t/sysroot/usr
COPY --from=builder2 /etc /opt/l4t/sysroot/etc
COPY --from=builder2 /opt /opt/l4t/sysroot/opt
COPY --from=builder2 /bin /opt/l4t/sysroot/bin
COPY --from=builder2 /sbin /opt/l4t/sysroot/sbin
COPY --from=builder2 /lib /opt/l4t/sysroot/lib

ADD https://developer.nvidia.com/embedded/dlc/l4t-gcc-7-3-1-toolchain-64-bit /tmp
RUN tar xvf /tmp/l4t-gcc-7-3-1-toolchain-64-bit -C tmp && \
mv /tmp/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu /opt/l4t/

FROM ubuntu:20.04

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt /opt
COPY --from=builder /bin /bin
COPY --from=builder /sbin /sbin
COPY --from=builder /lib /lib

ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
