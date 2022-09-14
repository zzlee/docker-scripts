FROM qcap-registry:5000/l4t-base:r35.1.0 AS l4t_base

FROM ubuntu:20.04 AS builder

# Jetson L4T Root FS
COPY --from=l4t_base /usr /opt/l4t/rootfs/usr
COPY --from=l4t_base /etc /opt/l4t/rootfs/etc
COPY --from=l4t_base /opt /opt/l4t/rootfs/opt
COPY --from=l4t_base /bin /opt/l4t/rootfs/bin
COPY --from=l4t_base /sbin /opt/l4t/rootfs/sbin
COPY --from=l4t_base /lib /opt/l4t/rootfs/lib

# Symbolic links
ADD http://qcap-registry:8888/relink.sh /opt/l4t/
RUN chmod +x /opt/l4t/relink.sh
RUN find /opt/l4t/rootfs/etc -type l -exec /opt/l4t/relink.sh {} \;
RUN find /opt/l4t/rootfs/usr/local -type l -exec /opt/l4t/relink.sh {} \;
RUN find /opt/l4t/rootfs/usr/lib -type l -exec /opt/l4t/relink.sh {} \;
RUN find /opt/l4t/rootfs/usr/bin -type l -exec /opt/l4t/relink.sh {} \;
RUN find /opt/l4t/rootfs/usr/sbin -type l -exec /opt/l4t/relink.sh {} \;
RUN find /opt/l4t/rootfs/usr/include -type l -exec /opt/l4t/relink.sh {} \;
RUN cd /opt/l4t/rootfs/usr/lib && \
ln -sf aarch64-linux-gnu/crt1.o crt1.o && \
ln -sf aarch64-linux-gnu/crti.o crti.o && \
ln -sf aarch64-linux-gnu/crtn.o crtn.o

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && \
apt-get install -y software-properties-common bash-completion \
build-essential git vim wget cpio tcl python

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" && \
apt-get update && \
apt-get -y install cuda-nvcc-11-4

# CMake
RUN apt-get install -y libssl-dev libncurses-dev && \
cd /tmp && git clone https://github.com/Kitware/CMake.git && \
cd CMake && git checkout v3.22.3 -b build-branch && \
./configure && make && make install

# NASM
RUN apt-get install -y libtool && \
cd /tmp && wget https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz && \
tar xvf nasm-2.15.05.tar.gz && cd nasm-2.15.05 && \
./autogen.sh && ./configure && make && make install

# Toolchain
ADD http://qcap-registry:8888/l4t-cross-r35-1-0/aarch64--glibc--stable-final.tar.gz /tmp/
RUN mkdir /opt/l4t/toolchain -p && \
tar xvf /tmp/aarch64--glibc--stable-final.tar.gz -C /opt/l4t/toolchain

ADD env-setup /opt/l4t/
ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN ldconfig
RUN apt-get autoremove -y && apt-get clean

# # Re-link libs
# RUN cd /opt/l4t/rootfs/usr/lib/aarch64-linux-gnu && \
# ln -fs libBrokenLocale.so.1 libBrokenLocale.so && \
# ln -fs libanl.so.1 libanl.so && \
# ln -fs libblkid.so.1.1.0 libblkid.so && \
# ln -fs libcrypt.so.1.1.0 libcrypt.so && \
# ln -fs libexpat.so.1.6.11 libexpat.so && \
# ln -fs liblzma.so.5.2.4 liblzma.so && \
# ln -fs libm.so.6 libm.so && \
# ln -fs libmount.so.1.1.0 libmount.so && \
# ln -fs libnsl.so.1 libnsl.so && \
# ln -fs libnss_compat.so.2 libnss_compat.so && \
# ln -fs libnss_dns.so.2 libnss_dns.so && \
# ln -fs libnss_files.so.2 libnss_files.so && \
# ln -fs libnss_hesiod.so.2 libnss_hesiod.so && \
# ln -fs libnss_nis.so.2 libnss_nis.so && \
# ln -fs libnss_nisplus.so.2 libnss_nisplus.so && \
# ln -fs libpcre.so.3 libpcre.so && \
# ln -fs libpthread.so.0 libpthread.so && \
# ln -fs libresolv.so.2 libresolv.so && \
# ln -fs librt.so.1 librt.so && \
# ln -fs libselinux.so.1 libselinux.so && \
# ln -fs libsepol.so.1 libsepol.so && \
# ln -fs libthread_db.so.1 libthread_db.so && \
# ln -fs libutil.so.1 libutil.so && \
# ln -fs libuuid.so.1.3.0 libuuid.so && \
# ln -fs libz.so.1.2.11 libz.so && \
# ln -fs openmpi/lib/libmpi_cxx.so libmpi++.so && \
# ln -fs openmpi/lib/libmpi.so libmpi.so && \
# ln -fs libdl.so.2 libdl.so && \
# ln -fs blas/libblas.so.3 libblas.so.3 && \
# ln -fs lapack/liblapack.so.3 liblapack.so.3

# RUN cd /opt/l4t/rootfs/usr/local && \
# ln -fsn cuda-11.4 cuda-11 && \
# ln -fsn cuda-11 cuda
