#/bin/sh

find ../qcap-dev/qcap/build-* -name *.tar.gz -exec rm {} \;

./build.sh hisiv hi3531a
./build.sh hisiv hi3531a400
./build.sh hisiv hi3531d
./build.sh hisiv hi3519a
./build.sh hisiv hi3559a

./build.sh ubuntu1804_x64 ubuntu1804_x64
./build.sh ubuntu1804_x64 ubuntu1804-cuda_x64

./build.sh ubuntu1604_x64 ubuntu1604_x64
./build.sh ubuntu1604_x64 ubuntu1604-cuda_x64

./build.sh centos76_x64 centos76_x64
./build.sh centos76_x64 centos76-cuda_x64