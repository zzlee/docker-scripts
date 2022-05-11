FROM nvcr.io/nvidia/l4t-base:r32.5.0 as builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion build-essential git vim wget cpio

# CMake
RUN apt-get install -y libssl-dev libncurses-dev
RUN cd /tmp && git -c http.sslVerify=false clone https://github.com/Kitware/CMake.git && cd CMake && git checkout v3.22.3 -b build-branch && ./configure && make && make install

# 3rdparty libs
RUN apt-get install -y libasound-dev libfontconfig-dev libgstreamer1.0-dev \
	libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev \
	libgstreamer-plugins-good1.0-dev libx11-dev libxv-dev libv4l-dev

# CUDA
ADD http://qcap-registry:8888/cuda/cuda_11.1.0_455.23.05_linux_sbsa.run /tmp
RUN cd /tmp && chmod +x ./cuda_11.1.0_455.23.05_linux_sbsa.run && \
./cuda_11.1.0_455.23.05_linux_sbsa.run --silent --toolkit
ADD http://qcap-registry:8888/l4t-r32-5-0/tegra.tar.gz /tmp
RUN tar xvf /tmp/tegra.tar.gz -C /

ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN ldconfig
RUN apt-get autoremove -y && apt-get clean

FROM nvcr.io/nvidia/l4t-base:r32.5.0

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt /opt
COPY --from=builder /bin /bin
COPY --from=builder /sbin /sbin
COPY --from=builder /lib /lib
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
