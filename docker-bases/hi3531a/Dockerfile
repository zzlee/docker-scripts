FROM yuan88yuan/hisiv300:v1 as builder

RUN apt-get update -y
RUN apt-get install -y autoconf pkg-config

ADD env-setup /opt/hisi-linux/
ADD harfbuzz.mk /tmp
RUN cd /tmp && make -f harfbuzz.mk

RUN apt-get autoremove -y && apt-get clean

FROM ubuntu:16.04

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt/hisi-linux /opt/hisi-linux
COPY --from=builder /opt/hi3531a-sdk/Hi3531A_SDK_V1.0.2.0/mpp/ /opt/hi3531a-sdk/Hi3531A_SDK_V1.0.2.0/mpp/
COPY --from=builder /bin /bin
COPY --from=builder /sbin /sbin
COPY --from=builder /lib /lib
COPY --from=builder /lib64 /lib64
COPY --from=builder /lib32 /lib32
COPY --from=builder /libx32 /libx32
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
