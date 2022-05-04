FROM qcap-registry:5000/centos:7.8.2003

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update package infos first
RUN yum update -y

# Essentials
RUN yum install -y iproute gcc gcc-c++ net-tools ncurses-devel zlib-devel openssl-devel flex bison libselinux xterm autoconf libtool texinfo \
	SDL-devel glibc-devel glibc.i686 glibc.x86_64 glib2-devel automake screen pax libstdc++.x86_64 libstdc++.i686 gawk python3 python3-pip \
	python3-GitPython python3-jinja2 perl patch diffutils cpp perl-Data-Dumper perl-Text-ParseWords perl-Thread-Queue xz which sudo locales

# Add entry point, we use entrypoint.sh to mapping host user to
# container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
