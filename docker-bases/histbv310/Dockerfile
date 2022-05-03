FROM ubuntu:20.04 AS builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion build-essential git vim wget cpio && apt clean

# CMake
RUN apt-get install -y libssl-dev libncurses-dev && apt clean
RUN cd /tmp && git clone https://github.com/Kitware/CMake.git && cd CMake && git checkout v3.22.3 -b build-branch && ./configure && make && make install && rm /tmp/* -r

# HiSTBV310
ADD http://qcap-registry:8888/histbv310/hisdk_arm-histbv310-linux.tar.gz /tmp/
RUN tar xvf /tmp/hisdk_arm-histbv310-linux.tar.gz -C /opt/ && rm /tmp/* -r
ADD environment-setup /opt/hisdk/

RUN apt-get -y install libtool pkg-config

# Add entry point, we use entrypoint.sh to mapping host user to
# container
ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get autoremove -y && apt-get clean

FROM ubuntu:20.04

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt /opt
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
