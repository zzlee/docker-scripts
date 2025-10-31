FROM yuan88yuan/l4t-base:r38.2-iso AS builder

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD apt.tar.gz /
RUN apt-get update -y
RUN apt-get install -y build-essential software-properties-common
RUN apt-get install -y bash-completion git vim wget cpio tcl cmake autoconf libtool

# Jetson packages
ADD Jetson_Linux_R38.2.1_aarch64.tbz2 /tmp/
RUN find /tmp/Linux_for_Tegra/nv_tegra/l4t_deb_packages/*.deb -exec dpkg -x {} /tmp/jetson-rootfs \;
RUN cp /tmp/jetson-rootfs/usr/* /usr -ar
RUN rm /tmp/Linux_for_Tegra /tmp/jetson-rootfs -r

RUN apt-get install -y libasound-dev libfontconfig-dev libgstreamer1.0-dev \
libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev \
libgstreamer-plugins-good1.0-dev libx11-dev libxv-dev libv4l-dev libvdpau-dev \
libdrm-dev libjpeg8-dev libva-dev
RUN apt-get install -y cuda-cudart-dev-13-0 nvidia-tensorrt-dev libnpp-dev-13-0 \
nvidia-opencv-dev

# Jetson multimedia API
ADD Jetson_Multimedia_API_R38.2.1_aarch64.tbz2 /

RUN ldconfig
RUN apt-get autoremove -y && apt-get clean

RUN groupadd build --gid 1000 && \
useradd build --shell /bin/bash --create-home --uid 1000 --gid 1000 -G sudo && \
echo 'build:build' | chpasswd

USER build
