FROM nvcr.io/nvidia/l4t-base:r34.1 as builder

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

ADD http://qcap-registry:8888/l4t-base-r34-1/jetson-ota-public.asc /etc/apt/trusted.gpg.d/
RUN chmod go=r /etc/apt/trusted.gpg.d/jetson-ota-public.asc
ADD http://qcap-registry:8888/l4t-base-r34-1/nvidia-l4t-apt-source.list /etc/apt/sources.list.d/
RUN chmod go=r /etc/apt/sources.list.d/nvidia-l4t-apt-source.list
RUN apt-get install -y ca-certificates && apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y cuda-cudart-dev-11-4 libnpp-dev-11-4 \
	libnvparsers-dev libnvinfer-dev cuda-nvcc-11-4 libnvonnxparsers-dev libdrm-dev

ADD http://qcap-registry:8888/l4t-r34-1/nvidia_drivers.tbz2 /tmp
RUN tar xvf /tmp/nvidia_drivers.tbz2 usr/lib/aarch64-linux-gnu/tegra/ -C /

ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get autoremove -y && apt-get clean

FROM nvcr.io/nvidia/l4t-base:r34.1

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt /opt
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
