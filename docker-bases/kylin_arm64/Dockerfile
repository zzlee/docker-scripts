FROM yuan88yuan/kylin-arm64-base:v10-sp1 as builder

# ENV TZ=Asia/Taipei
# ENV DEBIAN_FRONTEND noninteractive
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# # RUN apt-get update -y
# RUN apt-get install -y bash-completion build-essential git vim wget cpio

# # CMake
# RUN apt-get install -y libssl-dev libncurses-dev
# RUN mkdir /tmp -p && cd /tmp && \
# git clone https://github.com/Kitware/CMake.git && cd CMake && \
# git checkout v3.22.3 -b build-branch
# RUN cd /tmp/CMake && ./configure
# RUN cd /tmp/CMake && make -j $(( $(nproc) + 1 )) && make install

# # NASM
# RUN apt-get install -y libtool
# RUN cd /tmp && wget https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz && \
# tar xvf nasm-2.15.05.tar.gz
# RUN cd /tmp/nasm-2.15.05 ./autogen.sh && ./configure && \
# make -j $(( $(nproc) + 1 )) && make install

# 3rdparty libs
RUN apt-get install -y libasound2-dev libx11-dev \
libxv-dev libva-dev libvdpau-dev libfontconfig1-dev \
libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
libgstreamer-plugins-bad1.0-dev libi2c-dev libudev-dev

RUN apt-get install -y automake libtool

# build 3rdparty libs
ADD boost.mk /tmp
RUN cd /tmp && make -f ./boost.mk
ADD fdk-aac.mk /tmp
RUN cd /tmp && make -f ./fdk-aac.mk
ADD x264.mk /tmp
RUN cd /tmp && make -f ./x264.mk
ADD zlib.mk /tmp
RUN cd /tmp && make -f ./zlib.mk
ADD openssl.mk /tmp
RUN cd /tmp && make -f ./openssl.mk
ADD freetype.mk /tmp
RUN cd /tmp && make -f ./freetype.mk
ADD iconv.mk /tmp
RUN cd /tmp && make -f ./iconv.mk
ADD uuid.mk /tmp
RUN cd /tmp && make -f ./uuid.mk
ADD sdl.mk /tmp
RUN cd /tmp && make -f ./sdl.mk
ADD module_vars.sh /tmp
ADD ffmpeg.mk /tmp
RUN cd /tmp && make -f ./ffmpeg.mk
ADD fcgi.mk /tmp
RUN cd /tmp && make -f ./fcgi.mk

ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get autoremove -y && apt-get clean

# Remove user kylin
RUN deluser kylin && sed -i '$d' /etc/uid_list

# FROM kylin:v10-sp1

# COPY --from=builder /usr /usr
# COPY --from=builder /etc /etc
# COPY --from=builder /opt /opt
# COPY --from=builder /bin /bin
# COPY --from=builder /sbin /sbin
# COPY --from=builder /lib /lib
# COPY --from=builder /entrypoint.sh /
# ENTRYPOINT ["/entrypoint.sh"]
