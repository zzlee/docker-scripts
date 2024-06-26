FROM centos:centos7.6.1810 AS builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
# RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum update -y
RUN yum groupinstall -y 'Development Tools'
RUN yum install -y git bash-completion wget cpio

# CMake
RUN yum install -y openssl-devel ncurses-devel
RUN cd /tmp && git clone https://github.com/Kitware/CMake.git && \
	cd CMake && git checkout v3.22.3 -b build-branch
RUN cd /tmp/CMake && ./configure
RUN cd /tmp/CMake && make -j $(( $(nproc) + 1 )) && make install

# NASM
RUN cd /tmp && wget https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz && \
	tar xvf nasm-2.15.05.tar.gz
RUN cd /tmp/nasm-2.15.05 && ./autogen.sh && ./configure
RUN cd /tmp/nasm-2.15.05 && make -j $(( $(nproc) + 1 )) && make install

# 3rdparty libs
RUN yum install -y alsa-lib-devel libX11-devel libXv-devel \
libva-devel libvdpau fontconfig-devel gstreamer1-devel \
gstreamer1-plugins-base-devel mesa-libGL-devel

# IPP
ADD http://qcap-registry:8888/ipp/my-silent-1.cfg /tmp
ADD http://qcap-registry:8888/ipp/COM_L_IPP__CJ7V-MJ9WNCJZ.lic /tmp
ADD http://qcap-registry:8888/ipp/l_ipp_8.1.0.144.tgz /tmp
RUN tar xvf /tmp/l_ipp_8.1.0.144.tgz -C tmp
RUN cd /tmp/l_ipp_8.1.0.144 && ./install.sh -s /tmp/my-silent-1.cfg

# CUDA
ADD http://qcap-registry:8888/cuda/cuda_11.6.2_510.47.03_linux.run /tmp
RUN chmod +x /tmp/cuda_11.6.2_510.47.03_linux.run
RUN yum install -y which
RUN /tmp/cuda_11.6.2_510.47.03_linux.run --silent --toolkit

# nv-codec-headers
RUN cd /tmp && git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
RUN	cd /tmp/nv-codec-headers && make install

# ADD boost.mk /tmp
# RUN cd /tmp && make -f ./boost.mk
# ADD fdk-aac.mk /tmp
# RUN cd /tmp && make -f ./fdk-aac.mk
# ADD zlib.mk /tmp
# RUN cd /tmp && make -f ./zlib.mk
# ADD x264.mk /tmp
# RUN cd /tmp && make -f ./x264.mk
# ADD openssl.mk /tmp
# RUN cd /tmp && make -f ./openssl.mk
# ADD freetype.mk /tmp
# RUN cd /tmp && make -f ./freetype.mk
# ADD iconv.mk /tmp
# RUN cd /tmp && make -f ./iconv.mk
# ADD uuid.mk /tmp
# RUN cd /tmp && make -f ./uuid.mk
# ADD sdl.mk /tmp
# RUN cd /tmp && make -f ./sdl.mk
# ADD module_vars.sh /tmp
# ADD ffmpeg-vaapi.mk /tmp
# RUN cd /tmp && make -f ./ffmpeg-vaapi.mk
# ADD ffmpeg-cuda.mk /tmp
# RUN cd /tmp && make -f ./ffmpeg-cuda.mk
# ADD fcgi.mk /tmp
# RUN cd /tmp && make -f ./fcgi.mk
# ADD yuv.mk /tmp
# RUN cd /tmp && make -f ./yuv.mk

# Add entry point, we use entrypoint.sh to mapping host user to
# container
ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN yum autoremove -y && yum clean all -y

# FROM centos:centos7.6.1810

# COPY --from=builder /usr /usr
# COPY --from=builder /etc /etc
# COPY --from=builder /opt /opt
# COPY --from=builder /entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]
