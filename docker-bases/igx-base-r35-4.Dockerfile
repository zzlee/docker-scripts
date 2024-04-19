FROM --platform=linux/arm64/v8 nvcr.io/nvidia/clara-holoscan/holoscan:v0.6.0-dgpu as build

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y build-essential software-properties-common
RUN apt-get install -y bash-completion git vim wget cpio tcl cmake autoconf libtool bison flex

RUN apt-get install -y libasound-dev libfontconfig-dev libgstreamer1.0-dev \
libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev \
libgstreamer-plugins-good1.0-dev libx11-dev libxv-dev libv4l-dev libvdpau-dev \
libdrm-dev libboost-all-dev libjpeg8-dev libva-dev libgbm-dev libudev-dev
RUN apt-get install -y libssl-dev ragel

RUN ldconfig
RUN apt-get autoremove -y && apt-get clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
