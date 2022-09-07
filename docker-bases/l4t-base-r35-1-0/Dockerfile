FROM nvcr.io/nvidia/l4t-base:r35.1.0 AS l4t_base

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# RUN apt-key adv --fetch-key https://repo.download.nvidia.com/jetson/jetson-ota-public.asc
RUN echo "deb https://repo.download.nvidia.com/jetson/t234 r35.1 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list

RUN apt-get update -y && \
apt-get install -y build-essential libasound-dev libfontconfig-dev libgstreamer1.0-dev \
libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev \
libgstreamer-plugins-good1.0-dev libx11-dev libxv-dev libv4l-dev libvdpau-dev \
libfdk-aac-dev libssl-dev libfreetype6-dev libdrm-dev \
cuda-cudart-dev-11-4 nvidia-tensorrt-dev libnpp-dev-11-4

# Jetson packages
RUN apt-get install -y curl
RUN curl -L https://developer.nvidia.com/embedded/l4t/r35_release_v1.0/release/jetson_linux_r35.1.0_aarch64.tbz2 | \
tar -jx -C /tmp/
RUN find /tmp/Linux_for_Tegra/nv_tegra/l4t_deb_packages/*.deb -exec dpkg -x {} /tmp/jetson-rootfs \;
RUN cp /tmp/jetson-rootfs/usr/* /usr -ar
RUN rm /tmp/Linux_for_Tegra /tmp/jetson-rootfs -r

# Utilities
RUN apt-get update -y && \
apt-get install -y software-properties-common bash-completion \
build-essential git vim wget cpio tcl python cmake

RUN ldconfig
RUN apt-get autoremove -y && apt-get clean

ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
