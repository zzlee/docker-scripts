FROM nvcr.io/nvidia/l4t-base:r32.7.1 AS builder

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y ca-certificates

RUN echo "deb [trusted=yes] https://repo.download.nvidia.com/jetson/common r32.7 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list
RUN echo "deb [trusted=yes] https://repo.download.nvidia.com/jetson/t186 r32.7 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list

RUN apt-get update -y
RUN apt-get install -y build-essential software-properties-common
RUN apt-get install -y bash-completion git vim wget cpio tcl cmake autoconf libtool ragel

# Jetson packages
ADD Jetson_Linux_R32.7.4_aarch64.tbz2 /tmp/
RUN find /tmp/Linux_for_Tegra/nv_tegra/l4t_deb_packages/*.deb -exec dpkg -x {} /tmp/jetson-rootfs \;
RUN cp /tmp/jetson-rootfs/usr/* /usr -ar
RUN rm /tmp/Linux_for_Tegra /tmp/jetson-rootfs -r

RUN apt-get install -y libasound-dev libfontconfig-dev libgstreamer1.0-dev \
libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev \
libgstreamer-plugins-good1.0-dev libx11-dev libxv-dev libv4l-dev libvdpau-dev \
libdrm-dev libboost-all-dev libjpeg8-dev libva-dev libgbm-dev libudev-dev libharfbuzz-dev
RUN apt-get install -y cuda-cudart-dev-10-2 libnpp-dev-10-2

# Jetson multimedia API
ADD nvidia-l4t-jetson-multimedia-api_32.7.4-20230608211515_arm64.deb /tmp
RUN dpkg -x /tmp/nvidia-l4t-jetson-multimedia-api_32.7.4-20230608211515_arm64.deb /
RUN rm /tmp/nvidia-l4t-jetson-multimedia-api_32.7.4-20230608211515_arm64.deb

RUN ldconfig
RUN apt-get autoremove -y && apt-get clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# FROM nvcr.io/nvidia/l4t-base:r32.7.1

# COPY --from=builder /usr /usr
# COPY --from=builder /etc /etc
# COPY --from=builder /opt /opt
# COPY --from=builder /entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]
