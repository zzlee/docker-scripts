FROM nvcr.io/nvidia/l4t-base:r35.1.0 AS builder

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN echo "deb https://repo.download.nvidia.com/jetson/t234 r35.1 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list

RUN apt-get update -y
RUN apt-get install -y build-essential software-properties-common
RUN apt-get install -y bash-completion git vim wget cpio tcl cmake autoconf libtool ragel

# Jetson packages
ADD Jetson_Linux_R35.1.0_aarch64.tbz2 /tmp/
RUN find /tmp/Linux_for_Tegra/nv_tegra/l4t_deb_packages/*.deb -exec dpkg -x {} /tmp/jetson-rootfs \;
RUN cp /tmp/jetson-rootfs/usr/* /usr -ar
RUN rm /tmp/Linux_for_Tegra /tmp/jetson-rootfs -r

RUN apt-get install -y libasound-dev libfontconfig-dev libgstreamer1.0-dev \
libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev \
libgstreamer-plugins-good1.0-dev libx11-dev libxv-dev libv4l-dev libvdpau-dev \
libdrm-dev libboost-all-dev libjpeg8-dev libva-dev libgbm-dev libudev-dev libharfbuzz-dev
RUN apt-get install -y cuda-cudart-dev-11-4 nvidia-tensorrt-dev libnpp-dev-11-4 \
nvidia-opencv-dev

# Jetson multimedia API
ADD Jetson_Multimedia_API_R35.1.0_aarch64.tbz2 /

RUN ldconfig
RUN apt-get autoremove -y && apt-get clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM nvcr.io/nvidia/l4t-base:r35.1.0

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt /opt
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
