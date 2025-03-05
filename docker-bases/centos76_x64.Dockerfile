FROM centos:centos7.6.1810 AS builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD CentOS-Base.repo /etc/yum.repos.d/
RUN yum update -y
RUN yum groupinstall -y 'Development Tools'
RUN yum install -y git bash-completion wget cpio which

# 3rdparty libs
RUN yum install -y alsa-lib-devel libX11-devel libXv-devel \
libva-devel libvdpau fontconfig-devel gstreamer1-devel \
gstreamer1-plugins-base-devel mesa-libGL-devel libvdpau-devel \
systemd-devel libglvnd-opengl libXrandr libXrandr-devel

# IPP
ADD ipp.tar.gz /

# CUDA
ADD cuda.tar.gz /

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# RUN yum autoremove -y && yum clean all -y

# FROM centos:centos7.6.1810

# COPY --from=builder /usr /usr
# COPY --from=builder /etc /etc
# COPY --from=builder /opt /opt
# COPY --from=builder /entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]

