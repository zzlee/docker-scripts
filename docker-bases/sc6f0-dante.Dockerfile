FROM yuan88yuan/petalinux:ubuntu2204 as builder

ADD sdk.sh /tmp
RUN cd /tmp && chmod +x ./sdk.sh && ./sdk.sh -y -d /opt/sc6f0