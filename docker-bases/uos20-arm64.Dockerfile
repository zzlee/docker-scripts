FROM --platform=linux/arm64/v8 ubuntu:focal-20240216 as build

ADD usr.tar.gz /
ADD etc.tar.gz /

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
