FROM nvidia/cuda:11.6.1-base-ubuntu20.04 AS builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion build-essential \
git vim wget cpio tcl python locales libexpat1 libkeyutils1
RUN locale-gen zh_TW.UTF-8 && update-locale

RUN apt-get -y install cuda

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# FROM nvidia/cuda:11.6.1-base-ubuntu20.04

# COPY --from=builder /usr /usr
# COPY --from=builder /etc /etc
# COPY --from=builder /opt /opt
# COPY --from=builder /entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]
