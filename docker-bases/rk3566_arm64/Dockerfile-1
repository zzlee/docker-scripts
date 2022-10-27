FROM yuan88yuan/rk3566_arm64:v1 AS builder

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
