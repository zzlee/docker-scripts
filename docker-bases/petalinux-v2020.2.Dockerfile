FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN \
dpkg --add-architecture i386 && \
apt-get update

RUN \
apt-get install -yq build-essential gawk gcc git make net-tools \
libncurses5-dev tftpd zlib1g-dev libssl-dev flex bison libselinux1 gnupg wget diffstat chrpath \
socat cpio python python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git \
python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm autoconf libtool texinfo \
gcc-multilib zlib1g:i386 curl locales rsync

RUN \
echo "dash dash/sh boolean false" | debconf-set-selections && \
dpkg-reconfigure dash

RUN apt-get install -yq lsb-release dnsutils

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo && chmod a+x /bin/repo
RUN sed -i "1s/python/python3/" /bin/repo
RUN groupadd build -g 1000
RUN useradd -ms /bin/bash -p build build -u 1000 -g 1000 && \
usermod -aG sudo build && \
echo "build:build" | chpasswd

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

ENV LANG en_US.utf8

USER build
WORKDIR /home/build
RUN git config --global user.email "build@example.com" && git config --global user.name "Build"

# ADD entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]
