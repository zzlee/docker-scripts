FROM ubuntu:18.04

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update package infos first
RUN apt-get update -y

# Essentials
RUN apt-get install -y adduser apt base-files base-passwd bash bash-completion binutils binutils-common cmake cmake-data git python

# Set the locale, else yocto will complain
RUN apt-get install locales -y
RUN locale-gen en_US.UTF-8 && \
	DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# make /bin/sh symlink to bash instead of dash
# Xilinx's petalinux need this
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# install petalinux SDK
#ADD sdk.sh /tmp/sdk.sh
#RUN chmod +x /tmp/sdk.sh
#RUN /tmp/sdk.sh -y -d /opt/sc6f0
#RUN rm /tmp/sdk.sh

COPY ./rootfs/usr /opt/sc6f0/sysroots/aarch64-xilinx-linux/usr

# Add entry point, we use entrypoint.sh to mapping host user to
# container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]