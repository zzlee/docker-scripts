FROM nvcr.io/nvidia/l4t-base:r32.4.4

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get install -y build-essential cmake sudo vim libasound-dev libfontconfig-dev libfreetype6-dev libgstreamer1.0-dev libgstreamer-plugins-bad1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev libxv-dev libssl-dev

COPY jetson-ota-public.asc /etc/apt/trusted.gpg.d/
COPY nvidia-l4t-apt-source.list /etc/apt/sources.list.d/
RUN apt-get update -y
RUN apt-get install -y cuda-cudart-dev-10-2 cuda-npp-dev-10-2

ADD tegra.tar.gz /

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
