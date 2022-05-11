FROM ubuntu:20.04 AS builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion build-essential git vim wget cpio

RUN apt-get install -y curl cmake python3
RUN apt-get install -u unzip
RUN groupadd -r devop && useradd -r -g devop devop && mkdir /opt/devop && chown devop:devop /opt/devop
USER devop

RUN wget https://www.orthanc-server.com/downloads/get.php?path=/orthanc/Orthanc-1.11.0.tar.gz -O /tmp/Orthanc-1.11.0.tar.gz && \
tar xzvf /tmp/Orthanc-1.11.0.tar.gz -C /tmp && \
cd /tmp/Orthanc-1.11.0 && \
mkdir build && cd build && \
cmake -DSTATIC_BUILD=ON -DCMAKE_BUILD_TYPE=Release ../OrthancServer/ && \
make -j 4

USER root
RUN cd /tmp/Orthanc-1.11.0/build && make install

#
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
COPY --from=builder /bin /bin
COPY --from=builder /sbin /sbin
COPY --from=builder /lib /lib
COPY --from=builder /lib64 /lib64
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
