FROM nvidia/cuda:11.6.1-base-ubuntu20.04 AS builder

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion build-essential \
git vim wget cpio tcl python locales libexpat1 libkeyutils1
RUN locale-gen zh_TW.UTF-8 && update-locale

RUN apt-get -y install cuda-11-6
RUN apt-get -y install automake libtool cmake yasm
ADD ipp.tar.gz /
RUN apt-get install -y libgl1-mesa-dev libxext-dev libasound2-dev libx11-dev \
libxv-dev libva-dev libvdpau-dev libfontconfig1-dev libgstreamer1.0-dev \
libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev libi2c-dev libudev-dev

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
