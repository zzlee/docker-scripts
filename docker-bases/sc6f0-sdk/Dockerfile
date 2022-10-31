FROM ubuntu:18.04 as builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion build-essential git vim wget cpio tcl python locales
RUN locale-gen zh_TW.UTF-8 && update-locale

# CMake
RUN apt-get install -y libssl-dev libncurses-dev
RUN cd /tmp && git clone https://github.com/Kitware/CMake.git && cd CMake && git checkout v3.22.3 -b build-branch && ./configure && make && make install

# install petalinux SDK
ADD http://qcap-registry:8888/sc6f0/sdk.sh /tmp/
RUN cd /tmp && chmod +x ./sdk.sh && ./sdk.sh -y -d /opt/sc6f0

# build 3rdparty libs
ADD xlnk_arm64.mk /tmp
ADD build-scripts/ /tmp/build-scripts/
RUN cd /tmp && make -f xlnk_arm64.mk

ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM ubuntu:18.04

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt /opt
COPY --from=builder /bin /bin
COPY --from=builder /sbin /sbin
COPY --from=builder /lib /lib
COPY --from=builder /lib64 /lib64
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
