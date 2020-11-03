FROM ubuntu:20.04

RUN dpkg --add-architecture i386

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update package infos first
RUN apt-get update -y

# Essentials
RUN apt-get install -y adduser apt base-files base-passwd bash bash-completion binutils binutils-common binutils-x86-64-linux-gnu bsdutils build-essential bzip2 ca-certificates cmake cmake-data coreutils cpio cpp cpp-7 dash debconf debianutils diffutils dirmngr dpkg dpkg-dev e2fsprogs fakeroot fdisk findutils fontconfig-config fonts-dejavu-core g++ g++-7 gcc gcc-7 gcc-7-base gcc-8-base git git-man gnupg gnupg-l10n gnupg-utils gpg gpg-agent gpg-wks-client gpg-wks-server gpgconf gpgsm gpgv grep gzip hostname i965-va-driver init-system-helpers krb5-locales less libacl1 libalgorithm-diff-perl libalgorithm-diff-xs-perl libalgorithm-merge-perl libarchive13 libasan4 libasn1-8-heimdal libasound2 libasound2-data libasound2-dev libassuan0 libatomic1 libattr1 libaudit-common libaudit1 libbinutils libblkid1 libbsd0 libbz2-1.0 libc-bin libc-dev-bin libc6 libc6-dev libcap-ng0 libcc1-0 libcilkrts5 libcom-err2 libcurl3-gnutls libcurl4 libdb5.3 libdebconfclient0 libdpkg-perl libdrm-amdgpu1 libdrm-common libdrm-intel1 libdrm-nouveau2 libdrm-radeon1 libdrm2 libedit2 libelf1 liberror-perl libexpat1 libexpat1-dev libext2fs2 libfakeroot libfdisk1 libfile-fcntllock-perl libfontconfig1 libfontconfig1-dev libfreetype6 libfreetype6-dev libgcc-7-dev libgcc1 libgcrypt20 libgdbm-compat4 libgdbm6 libgl1 libgl1-mesa-dri libglapi-mesa libglib2.0-0 libglib2.0-data libglvnd0 libglx-mesa0 libglx0 libgmp10 libgnutls30 libgomp1 libgpg-error0 libgssapi-krb5-2 libgssapi3-heimdal libhcrypto4-heimdal libheimbase1-heimdal libheimntlm0-heimdal libhx509-5-heimdal libicu-dev libidn2-0 libisl-dev libitm1 libjsoncpp1 libk5crypto3 libkeyutils1 libkrb5-26-heimdal libkrb5-3 libkrb5support0 libksba8 libldap-2.4-2 libldap-common libllvm10 liblocale-gettext-perl liblsan0 liblz4-1 liblzma5 liblzo2-2 libmount1 libmpc3 libmpfr6 libmpx2 libncurses5 libncursesw5 nettle-dev libnghttp2-14 libnpth0 libp11-kit0 libpam-modules libpam-modules-bin libpam-runtime libpam0g libpciaccess0 libpcre3 libperl-dev libpng-dev libpng-tools libpng16-16 libprocps-dev libpsl5 libpthread-stubs0-dev libquadmath0 libreadline-dev librhash0 libroken18-heimdal librtmp1 libsasl2-2 libsasl2-modules libsasl2-modules-db libseccomp2 libselinux1 libsemanage-common libsemanage1 libsensors4-dev libsepol1 libset-scalar-perl libsmartcols1 libsqlite3-0 libss2 libssl-dev libssl1.1 libstdc++-7-dev libstdc++6 libsystemd0 libtasn1-6 libtinfo5 libtsan0 libubsan0 libudev1 libunistring2 libuuid1 libuv1 libva-dev libva-drm2 libva-glx2 libva-wayland2 libva-x11-2 libva2 libwayland-bin libwayland-client0 libwayland-cursor0 libwayland-dev libwayland-egl1 libwayland-server0 libwind0-heimdal libx11-6 libx11-data libx11-dev libx11-doc libx11-xcb1 libxau-dev libxau6 libxcb-dri2-0 libxcb-dri3-0 libxcb-glx0 libxcb-present0 libxcb-sync1 libxcb-xfixes0 libxcb1 libxcb1-dev libxdamage1 libxdmcp-dev libxdmcp6 libxext-dev libxext6 libxfixes3 libxml2 libxmuu1 libxshmfence1 libxv-dev libxv1 libxxf86vm1 libzstd1 linux-libc-dev login lsb-base make manpages manpages-dev mawk mesa-va-drivers mount ncurses-base ncurses-bin netbase openssh-client openssl passwd patch perl perl-base perl-modules pinentry-curses pkg-config procps publicsuffix readline-common sed sensible-utils shared-mime-info sudo sysvinit-utils tar ubuntu-keyring ucf util-linux va-driver-all x11proto-core-dev x11proto-dev x11proto-xext-dev xauth xdg-user-dirs xorg-sgml-doctools xtrans-dev xz-utils zlib1g zlib1g-dev

# Set the locale, else yocto will complain
RUN apt-get install locales -y
RUN locale-gen en_US.UTF-8 && \
	DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# make /bin/sh symlink to bash instead of dash
# Xilinx's petalinux need this
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# Add entry point, we use entrypoint.sh to mapping host user to
# container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
