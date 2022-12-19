FROM qcap-registry:5000/petalinux-base:v1 as builder

ADD http://qcap-registry:8888/petalinux/petalinux-v2022.2.tar.gz /tmp/petalinux-v2022.2.tar.gz
RUN tar xzvf /tmp/petalinux-v2022.2.tar.gz -C /opt/

FROM qcap-registry:5000/petalinux-base:v1

COPY --from=builder /opt/Xilinx/ /opt/Xilinx/
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
