FROM scratch

ADD rootfs.tar.gz /
ADD Jetson_Multimedia_API_r36.3.0_aarch64.tbz2 /

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && \
apt-get install -y build-essential software-properties-common bash-completion \
git vim wget cpio tcl python3 cmake

RUN apt-get install -y \
libasound2-dev libfontconfig-dev libdrm-dev libx11-dev libxv-dev libv4l-dev libvdpau-dev \
libgstreamer1.0-dev libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev \
libgstreamer-plugins-good1.0-dev

RUN apt-get install -y \
cuda-cudart-dev-12-2 nvidia-tensorrt-dev libnpp-dev-12-2

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

