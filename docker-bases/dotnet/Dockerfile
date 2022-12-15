FROM ubuntu:20.04

ENV TZ=Asia/Taipei
ENV DEBIAN_FRONTEND noninteractive
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y
RUN apt-get install -y wget dpkg
RUN cd tmp && \
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
dpkg -i packages-microsoft-prod.deb && \
rm packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install -y dotnet-sdk-6.0
RUN apt-get install -y dotnet-runtime-6.0 aspnetcore-runtime-6.0
RUN apt-get install -y libgstreamer1.0-0 libgstreamer-plugins-good1.0-0 \
libgstreamer-plugins-base1.0-0 libgstreamer-plugins-bad1.0-0 \
vainfo libxv-dev libopengl0 libasound-dev libgl-dev libegl-dev libxrandr-dev

ADD http://qcap-registry:8888/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get autoremove -y && apt-get clean

