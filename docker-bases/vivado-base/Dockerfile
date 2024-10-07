FROM yuan88yuan/petalinux:base

RUN apt-get update -y
RUN apt-get install libgtk2.0-0 libtinfo5 libncurses5 -y
RUN apt-get install libswt-gtk-4-java -y

ENTRYPOINT ["/entrypoint.sh"]
