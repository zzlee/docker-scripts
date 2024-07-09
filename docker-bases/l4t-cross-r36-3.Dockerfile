FROM yuan88yuan/l4t-base:r36.3 AS base
FROM ubuntu:22.04 AS builder

COPY --from=base / /opt/l4t/rootfs

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y software-properties-common bash-completion \
git vim wget cpio tcl cmake autoconf libtool pkg-config gtk-doc-tools

# relink rootfs
ADD relink.sh /opt/l4t
RUN chmod +x /opt/l4t/relink.sh
RUN find /opt/l4t/rootfs/etc -type l -exec /opt/l4t/relink.sh {} \;
RUN find /opt/l4t/rootfs/usr -type l -exec /opt/l4t/relink.sh {} \;
RUN cp /opt/l4t/rootfs/usr/lib/aarch64-linux-gnu/*.o /opt/l4t/rootfs/usr/lib/

ADD aarch64--glibc--stable-2022.08-1.tar.bz2 /opt/l4t
RUN cd /opt/l4t/aarch64--glibc--stable-2022.08-1 && ./relocate-sdk.sh

ADD qcap-dev-init /opt/
RUN chmod +x /opt/qcap-dev-init

RUN cd /tmp && \
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb && \
dpkg -i cuda-keyring_1.1-1_all.deb && \
apt-get update
RUN apt-get -y install cuda-nvcc-12-2

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
