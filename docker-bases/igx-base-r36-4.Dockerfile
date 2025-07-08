FROM --platform=linux/arm64/v8 arm64v8/ubuntu:jammy as build

ADD ./rootfs.tar.gz /

# remove 1000/1000 (gid/uid)
RUN delgroup weston-launch
RUN userdel --remove nvidia

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
