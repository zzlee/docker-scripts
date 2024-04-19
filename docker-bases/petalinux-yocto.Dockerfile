FROM ubuntu:20.04
MAINTAINER Kris Chaplin <kris.chaplin@amd.com>
# Modified from Cliff Brake's Ubuntu container  <cbrake@bec-systems.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN \
dpkg --add-architecture i386 && \
apt-get update && \
apt-get install -yq sudo build-essential git nano vim\
  python3-yaml libncursesw5 libncursesw5:i386 \
  python python3 man bash diffstat gawk chrpath wget cpio \
  texinfo lzop apt-utils bc screen libncurses5-dev locales \
  libc6-dev-i386 doxygen libssl-dev dos2unix xvfb x11-utils \
  g++-multilib libssl-dev:i386 zlib1g-dev:i386 \
  libtool libtool-bin procps python3-distutils pigz socat \
  zstd iproute2 lz4 iputils-ping \
  curl libtinfo5 net-tools xterm rsync u-boot-tools unzip zip && \
rm -rf /var/lib/apt-lists/* && \
echo "dash dash/sh boolean false" | debconf-set-selections && \
dpkg-reconfigure dash

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo && chmod a+x /bin/repo
# RUN sed -i "1s/python/python3/" /bin/repo
# RUN groupadd build -g 1000
# RUN useradd -ms /bin/bash -p build build -u 1000 -g 1000 && \
#         usermod -aG sudo build && \
#         echo "build:build" | chpasswd

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

ENV LANG en_US.utf8

# USER build
# WORKDIR /home/build
# RUN git config --global user.email "build@example.com" && git config --global user.name "Build"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
