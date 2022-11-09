FROM intel/oneapi-basekit

RUN apt-get update -y
RUN apt-get install -y automake autoconf pkg-config libva-dev vim libtool libdrm-dev sudo

# Add entry point, we use entrypoint.sh to mapping host user to
# container
ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
