FROM --platform=linux/arm64/v8 centos:centos8.4.2105 as build

# ADD ./bin.tar.gz /
ADD ./etc.tar.gz /
ADD ./usr.tar.gz /
ADD ./var.tar.gz /

RUN ln /usr/lib64 /lib64 -fs
RUN rm /etc/yum.repos.d/CentOS-Linux-*.repo

# Remove user kylin
# RUN userdel kylin && sed -i '$d' /etc/uid_list

ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
