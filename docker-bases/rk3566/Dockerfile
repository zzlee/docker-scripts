FROM ubuntu:18.04

# Update package infos first
RUN apt-get update -y

RUN apt-get install -y build-essential bash make cmake sudo automake libtool
RUN apt-get clean

ADD http://qcap-registry:8888/rk3566/rk3566_host.tar.bz2 /tmp
RUN tar xvf /tmp/rk3566_host.tar.bz2 -C /opt/

ADD environment-setup /opt/rk3566_host/

RUN apt-get autoremove -y && apt-get clean

ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
