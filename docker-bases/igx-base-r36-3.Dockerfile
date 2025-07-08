FROM --platform=linux/arm64/v8 nvcr.io/nvidia/clara-holoscan/holoscan:v2.7.0-dgpu as build

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD ./jetson-ota-public.asc /tmp
RUN \
	# EGL and libGLESv2 is needed by Argus api otherwise the library throws error \
	apt-get update && \
	# DEBIAN_FRONTEND=noninteractive apt-get install -y -q libgles2-mesa-dev && \
	echo "deb https://repo.download.nvidia.com/jetson/common r36.3 main" > /etc/apt/sources.list.d/nvidia-l4t-apt-source.list && \
	echo "deb https://repo.download.nvidia.com/jetson/t234 r36.3 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list && \
	cat /tmp/jetson-ota-public.asc | apt-key add - && \
	apt-get update && \
	rm -rf /tmp/jetson-ota-public.asc

ADD ./nvidia-l4t-jetson-multimedia-api_36.3.0-20240506102626_arm64.deb /tmp
RUN \
	# we do not have the permission to ./mm-api/DEBIAN/postinst \
	# to just install nvidia-l4t-jetson-multimedia-api via apt install \
	# apt-get download nvidia-l4t-jetson-multimedia-api && \
	dpkg-deb -R /tmp/nvidia-l4t-jetson-multimedia-api_*_arm64.deb ./mm-api && \
	cp -r ./mm-api/usr/src/jetson_multimedia_api /usr/src/jetson_multimedia_api && \
	sed -i 's/sudo//' ./mm-api/DEBIAN/postinst && \
	./mm-api/DEBIAN/postinst && \
	rm -rf /tmp/nvidia-l4t-jetson-multimedia-api_*_arm64.deb ./mm-api && \
	rm -rf /var/lib/apt/lists/*

ADD ./nvidia-l4t-multimedia_36.4.3-20250107174145_arm64.deb /tmp
RUN \
	dpkg -x /tmp/nvidia-l4t-multimedia_36.4.3-20250107174145_arm64.deb / && \
	rm -rf /tmp/nvidia-l4t-multimedia_36.4.3-20250107174145_arm64.deb

ADD ./nvidia-l4t-multimedia-utils_36.4.3-20250107174145_arm64.deb /tmp
RUN \
	dpkg -x /tmp/nvidia-l4t-multimedia-utils_36.4.3-20250107174145_arm64.deb / && \
	rm -rf /tmp/nvidia-l4t-multimedia-utils_36.4.3-20250107174145_arm64.deb

RUN apt-get update
RUN apt-get install -y build-essential software-properties-common \
bash-completion git vim wget cpio tcl cmake autoconf libtool bison flex

RUN apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-bad1.0-dev \
libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev

RUN apt-get install -y libasound-dev libfontconfig-dev libx11-dev \
libxv-dev libv4l-dev libvdpau-dev libdrm-dev libjpeg8-dev \
libva-dev libgbm-dev libudev-dev libssl-dev ragel libfmt-dev libopengl-dev

RUN apt-get install -y \
cuda-cudart-dev-12-6 libnpp-dev-12-6

ADD rootfs.tar.gz /
ADD nvidia.tar.gz /
ADD nvidia-tegra.conf /etc/ld.so.conf.d/
# RUN ln /usr/local/cuda/lib64/stubs/libcuda.so /usr/lib/aarch64-linux-gnu/libcuda.so -fs

RUN ldconfig
# RUN apt-get autoremove -y && apt-get clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
