FROM arm64v8/debian:bullseye

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update package infos first
RUN apt-get update -y

# Essentials
RUN apt-get install -y adduser apt base-files base-passwd bash bash-completion binutils build-essential xz-utils cmake git vim zlib1g zlib1g-dev libboost-dev libz-dev libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libresample-dev libavdevice-dev libfontconfig1-dev libasound-dev libboost-all-dev libx11-dev libxv-dev locales automake autopoint libtool libglib2.0-dev texinfo libi2c-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libglib2.0-dev avahi-utils

# Set the locale, else yocto will complain
RUN locale-gen en_US.UTF-8 && \
	DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# make /bin/sh symlink to bash instead of dash
# Xilinx's petalinux need this
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

COPY ./rootfs/usr /usr
RUN ldconfig

# Add entry point, we use entrypoint.sh to mapping host user to
# container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
