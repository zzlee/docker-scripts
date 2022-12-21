FROM qcap-registry:5000/petalinux-base:v1

RUN apt-get update -y
RUN apt-get install libgtk2.0-0 libtinfo5 libncurses5 -y
RUN apt-get install libswt-gtk-4-java -y

ENTRYPOINT ["/entrypoint.sh"]

RUN apt-get autoremove -y && apt-get clean
