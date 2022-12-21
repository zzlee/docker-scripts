FROM qcap-registry:5000/vivado-base:v1 as builder

ADD http://qcap-registry:8888/vivado/vivado-v2020.2.tar.gz /tmp/vivado-v2020.2.tar.gz
RUN tar xzvf /tmp/vivado-v2020.2.tar.gz -C /

FROM qcap-registry:5000/vivado-base:v1

COPY --from=builder /opt/tools/ /opt/tools/
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
