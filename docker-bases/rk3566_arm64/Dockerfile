FROM yuan88yuan/rk3566_arm64:v1 AS builder

# build 3rdparty libs
ADD fcgi.mk /tmp
RUN cd /tmp && make -f ./fcgi.mk

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
