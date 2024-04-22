FROM ubuntu:20.04 AS builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN dpkg --add-architecture i386
RUN apt-get update -y
RUN apt-get install -y bash-completion autoconf libtool \
git vim wget cpio tcl python locales libexpat1 libkeyutils1 pkg-config bc kmod
RUN apt-get install -y libc6-dev libncurses5-dev libncurses5:i386 \
libgl1-mesa-dev g++-multilib mingw-w64 tofrodos lib32z1 u-boot-tools zlib1g-dev \
bison libbison-dev flex mtd-utils vim squashfs-tools gawk cmake cmake-data \
liblz4-tool libmpc3 libstdc++6 device-tree-compiler android-sdk-libsparse-utils \
android-sdk-ext4-utils texinfo libssl-dev lzop
RUN DEBIAN_FRONTEND=noninteractive apt install sudo
RUN apt install dosfstools
RUN locale-gen zh_TW.UTF-8 && update-locale

ADD aarch64-ca53-linux-gnueabihf-8.4.01.tar.bz2 /opt/
ADD sdk.tar.gz /opt/novatek-sdk/

RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

ADD qcap-dev-init /opt/
RUN chmod +x /opt/qcap-dev-init

# RUN ldconfig
# RUN apt-get autoremove -y && apt-get clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# FROM ubuntu:20.04

# COPY --from=builder /usr /usr
# COPY --from=builder /etc /etc
# COPY --from=builder /opt /opt
# COPY --from=builder /entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]
