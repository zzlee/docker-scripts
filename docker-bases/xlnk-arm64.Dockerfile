FROM debian:buster-slim AS builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion build-essential git vim wget cpio tcl python locales
RUN locale-gen zh_TW.UTF-8 && update-locale

# platform SDK
ADD sdk.sh /tmp/
RUN cd /tmp && chmod +x ./sdk.sh && ./sdk.sh -y -d /opt/sc6f0
ADD generated.tar.gz /opt/sc6f0/sysroots/aarch64-xilinx-linux/lib/modules/5.4.0-xilinx-v2020.2/build/
RUN ln /opt/sc6f0/environment-setup-aarch64-xilinx-linux /opt/qcap-dev-init -fs && \
chmod +x /opt/qcap-dev-init

RUN ldconfig
RUN apt-get autoremove -y && apt-get clean

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM debian:buster-slim

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt /opt
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
