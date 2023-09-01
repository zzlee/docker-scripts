FROM centos:centos6.6 AS builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
# RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

ADD http://qcap-registry:8888/centos66_x64/CentOS-Base.repo /tmp
RUN mv /tmp/CentOS-Base.repo /etc/yum.repos.d/ -f
RUN yum update -y
RUN yum groupinstall -y 'Development Tools'
RUN yum install -y git bash-completion wget cpio tar perl-ExtUtils-MakeMaker asciidoc

# NASM
# RUN cd /tmp && wget https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz && \
# 	tar xvf nasm-2.15.05.tar.gz
# RUN cd /tmp/nasm-2.15.05 && ./autogen.sh && ./configure
# RUN cd /tmp/nasm-2.15.05 && make -j $(( $(nproc) + 1 )) && make install

# 3rdparty libs
RUN yum install -y alsa-lib-devel libX11-devel libXv-devel libva-devel libvdpau fontconfig-devel \
gstreamer1-devel gstreamer1-plugins-base-devel curl-devel expat-devel gettext-devel openssl-devel \
zlib-devel

# IPP
ADD http://qcap-registry:8888/ipp/my-silent-1.cfg /tmp
# ADD http://qcap-registry:8888/ipp/COM_L_IPP__CJ7V-MJ9WNCJZ.lic /tmp
# ADD http://qcap-registry:8888/ipp/l_ipp_8.1.0.144.tgz /tmp
# RUN tar xvf /tmp/l_ipp_8.1.0.144.tgz -C tmp
# RUN cd /tmp/l_ipp_8.1.0.144 && ./install.sh -s /tmp/my-silent-1.cfg

# Upgrade git
RUN yum remove -y git
RUN cd /tmp && \
wget https://github.com/git/git/archive/v2.2.1.tar.gz && \
tar xvf v2.2.1.tar.gz
RUN cd /tmp/git-2.2.1 && \
make configure && \
./configure --prefix=/usr/local/git --with-iconv=/usr/local/libiconv
RUN cd /tmp/git-2.2.1 && \
make all -j8 && \
make install && \
echo "export PATH=$PATH:/usr/local/git/bin" >> /etc/bashrc

ADD boost.mk /tmp
ADD zlib.mk /tmp
ADD openssl.mk /tmp
ADD freetype.mk /tmp
ADD iconv.mk /tmp
ADD uuid.mk /tmp
ADD sdl.mk /tmp
ADD fcgi.mk /tmp
ADD yuv.mk /tmp
ADD module_vars.sh /tmp
ADD ffmpeg.mk /tmp

# RUN cd /tmp && make -f ./boost.mk
# RUN cd /tmp && make -f ./zlib.mk
# RUN cd /tmp && make -f ./openssl.mk
# RUN cd /tmp && make -f ./freetype.mk
# RUN cd /tmp && make -f ./iconv.mk
# RUN cd /tmp && make -f ./uuid.mk
# RUN cd /tmp && make -f ./sdl.mk
# RUN cd /tmp && make -f ./fcgi.mk
# RUN cd /tmp && make -f ./yuv.mk
# RUN cd /tmp && make -f ./ffmpeg.mk

# Add entry point, we use entrypoint.sh to mapping host user to
# container
ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# RUN yum autoremove -y && yum clean all -y

# FROM centos:centos7.6.1810

# COPY --from=builder /usr /usr
# COPY --from=builder /etc /etc
# COPY --from=builder /opt /opt
# COPY --from=builder /entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]
