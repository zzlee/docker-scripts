FROM ubuntu:18.04 as builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion build-essential git vim wget cpio libtool automake tcl

# CMake
RUN apt-get install -y libssl-dev libncurses-dev
RUN cd /tmp && git clone https://github.com/Kitware/CMake.git && cd CMake && git checkout v3.22.3 -b build-branch && ./configure && make && make install

ADD http://qcap-registry:8888/rk3566/rk3566_host.tar.bz2 /tmp
RUN tar xvf /tmp/rk3566_host.tar.bz2 -C /opt/

ADD environment-setup /opt/rk3566_host/

# build 3rdparty libs
ADD boost.mk /tmp
RUN cd /tmp && make -f ./boost.mk
ADD fdk-aac.mk /tmp
RUN cd /tmp && make -f ./fdk-aac.mk
ADD zlib.mk /tmp
RUN cd /tmp && make -f ./zlib.mk
ADD openssl.mk /tmp
RUN cd /tmp && make -f ./openssl.mk
ADD freetype.mk /tmp
RUN cd /tmp && make -f ./freetype.mk
ADD iconv.mk /tmp
RUN cd /tmp && make -f ./iconv.mk
ADD uuid.mk /tmp
RUN cd /tmp && make -f ./uuid.mk
ADD module_vars.sh /tmp
ADD ffmpeg.mk /tmp
RUN cd /tmp && make -f ./ffmpeg.mk
ADD fcgi.mk /tmp
RUN cd /tmp && make -f ./fcgi.mk

ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get autoremove -y && apt-get clean

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
