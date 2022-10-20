FROM ubuntu:16.04 AS builder

RUN dpkg --add-architecture i386
RUN apt-get update -y
RUN apt-get install -y make libc6:i386 lib32z1 lib32stdc++6 zlib1g-dev \
libncurses5-dev ncurses-term libncursesw5-dev g++ u-boot-tools:i386 texinfo \
texlive gawk libssl-dev openssl bc

# CMake 3.22.3
RUN apt-get install -y libssl-dev libncurses-dev
RUN apt-get install -y git
RUN cd /tmp && git clone https://github.com/Kitware/CMake.git && \
	cd CMake && git checkout v3.22.3 -b build-branch && \
	./configure && make -j $(( $(nproc) + 1 )) && make install

# Toolchain
RUN apt-get install -y lbzip2
ADD http://qcap-registry:8888/himix100/aarch64-himix100-linux.tgz /tmp
RUN cd /tmp && tar xzvf aarch64-himix100-linux.tgz && \
cd /tmp/aarch64-himix100-linux && ./aarch64-himix100-linux.install

# build 3rdparty libs
ADD hi3559a.mk /tmp
ADD build-scripts/ /tmp/build-scripts/
RUN apt-get install -y automake libtool pkg-config
RUN cd /tmp && make -f hi3559a.mk

# MPP SDK
ADD http://qcap-registry:8888/himix100/Hi3559AV100_SDK_V2.0.2.0.tgz /tmp
RUN cd /tmp && mkdir /opt/hi3559a-sdk -p && tar xzvf Hi3559AV100_SDK_V2.0.2.0.tgz -C /opt/hi3559a-sdk/
RUN cd /opt/hi3559a-sdk/Hi3559AV100_SDK_V2.0.2.0 && /bin/bash -c ". ./sdk.unpack"

# Add entry point, we use entrypoint.sh to mapping host user to
# container
ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get autoremove -y && apt-get clean

FROM ubuntu:16.04

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt/hisi-linux /opt/hisi-linux
COPY --from=builder /opt/hi3559a-sdk/Hi3559AV100_SDK_V2.0.2.0/mpp/ /opt/hi3559a-sdk/Hi3559AV100_SDK_V2.0.2.0/mpp/
COPY --from=builder /bin /bin
COPY --from=builder /sbin /sbin
COPY --from=builder /lib /lib
COPY --from=builder /lib64 /lib64
COPY --from=builder /lib32 /lib32
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
