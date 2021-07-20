FROM centos:7

RUN yum clean all
RUN rm /etc/yum.repos.d/*
COPY neokylin.repo /etc/yum.repos.d/
COPY neokylin-updates.repo /etc/yum.repos.d/
COPY RPM-GPG-KEY-neokylin* /etc/pki/rpm-gpg/

RUN yum makecache

# Add entry point, we use entrypoint.sh to mapping host user to
# container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
