FROM ubuntu:18.04 AS builder

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion build-essential git vim wget cpio

# # CMake
# RUN apt-get install -y libssl-dev libncurses-dev
# RUN cd /tmp && git clone https://github.com/Kitware/CMake.git && \
# 	cd CMake && git checkout v3.22.3 -b build-branch && \
# 	./configure && make -j $(( $(nproc) + 1 )) && make install

# NASM
RUN apt-get install -y libtool
RUN cd /tmp && wget https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz && \
	tar xvf nasm-2.15.05.tar.gz && cd nasm-2.15.05 && \
	./autogen.sh && ./configure && make -j $(( $(nproc) + 1 )) && make install

# 3rdparty libs
RUN apt-get install -y libasound2-dev libx11-dev libxv-dev libva-dev \
libvdpau-dev libfontconfig1-dev libgstreamer1.0-dev \
libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev \
libi2c-dev libudev-dev

# NASM
RUN apt-get install -y libtool
RUN cd /tmp && wget https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz && \
	tar xvf nasm-2.15.05.tar.gz && cd nasm-2.15.05 && \
	./autogen.sh && ./configure && make && make install

# IPP
ADD http://qcap-registry:8888/ipp/my-silent-1.cfg /tmp
ADD http://qcap-registry:8888/ipp/COM_L_IPP__CJ7V-MJ9WNCJZ.lic /tmp
ADD http://qcap-registry:8888/ipp/l_ipp_8.1.0.144.tgz /tmp
RUN tar xvf /tmp/l_ipp_8.1.0.144.tgz -C tmp
RUN cd /tmp/l_ipp_8.1.0.144 && ./install.sh -s /tmp/my-silent-1.cfg

# CUDA
ADD http://qcap-registry:8888/cuda/x86_64-cuda-ubuntu1804.pin /tmp
RUN mv /tmp/x86_64-cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
ADD http://qcap-registry:8888/cuda/cuda-repo-ubuntu1804-11-6-local_11.6.2-510.47.03-1_amd64.deb /tmp
RUN dpkg -i /tmp/cuda-repo-ubuntu1804-11-6-local_11.6.2-510.47.03-1_amd64.deb
RUN apt-key add /var/cuda-repo-ubuntu1804-11-6-local/7fa2af80.pub
RUN apt-get update
RUN apt-get -y install cuda

# nv-codec-headers
RUN cd /tmp && git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git && \
	cd nv-codec-headers && make install

# build 3rdparty libs
ADD ubuntu1804_x64.mk /tmp
ADD build-scripts/ /tmp/build-scripts/
# RUN cd /tmp && make -f ubuntu1804_x64.mk
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/boost/DONE
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/fdk-aac/DONE
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/x264/DONE
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/zlib/DONE
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/openssl/DONE
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/freetype/DONE
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/iconv/DONE
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/uuid/DONE
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/sdl/DONE
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/ffmpeg-vaapi/DONE
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/ffmpeg-cuda/DONE
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/fcgi/DONE
RUN cd /tmp && make -f ubuntu1804_x64.mk build-3rdparty/ubuntu1804_x64/yuv/DONE

# Add entry point, we use entrypoint.sh to mapping host user to
# container
ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get autoremove -y && apt-get clean

FROM ubuntu:18.04

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt /opt
COPY --from=builder /bin /bin
COPY --from=builder /sbin /sbin
COPY --from=builder /lib /lib
COPY --from=builder /lib64 /lib64
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
