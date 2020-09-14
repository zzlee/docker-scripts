#/bin/sh

mkdir -p ../qcap-builds
find ../qcap-dev/qcap/build-* -name *.tar.gz -exec cp {} ../qcap-builds \;
