FROM ubuntu:20.04 AS builder

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y bash-completion build-essential git vim wget cpio

# CMake
RUN apt-get install -y libssl-dev libncurses-dev
RUN cd /tmp && git clone https://github.com/Kitware/CMake.git && cd CMake && git checkout v3.22.3 -b build-branch && ./configure && make && make install

# 3rdparty libs
RUN apt-get install -y libasound2-dev libx11-dev libxv-dev libva-dev libvdpau-dev libfontconfig1-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev

# IPP
ADD http://qcap-registry:8888/ipp/my-silent.cfg /tmp
ADD http://qcap-registry:8888/ipp/l_ipp_8.1.0.144.tgz /tmp
RUN tar xvf /tmp/l_ipp_8.1.0.144.tgz -C tmp
RUN cd /tmp/l_ipp_8.1.0.144 && ./install.sh -s /tmp/my-silent.cfg

# CUDA
RUN apt-get install -y software-properties-common && cd /tmp && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub && add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install cuda

#
# Add entry point, we use entrypoint.sh to mapping host user to
# container
ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get autoremove -y && apt-get clean

FROM ubuntu:20.04

COPY --from=builder /usr /usr
COPY --from=builder /etc /etc
COPY --from=builder /opt /opt
COPY --from=builder /entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
