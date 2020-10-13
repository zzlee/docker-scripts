#/bin/sh

REPO=qcap-registry:5000
TAG=v1

./clean-all-builds.sh
rm ../qcap-builds/*.tar.gz

./build.sh ${REPO}/hisiv300:${TAG} hi3531a install
./build.sh ${REPO}/hisiv400:${TAG} hi3531a400 install
./build.sh ${REPO}/hisiv500:${TAG} hi3531d install
./build.sh ${REPO}/hisiv510:${TAG} hi3531a510 install
./build.sh ${REPO}/himix200:${TAG} hi3519a install
./build.sh ${REPO}/himix100:${TAG} hi3559a install

./build.sh ${REPO}/ubuntu1804_x64:${TAG} ubuntu1804_x64 install
./build.sh ${REPO}/ubuntu1804_x64:${TAG} ubuntu1804-cuda_x64 install

./build.sh ${REPO}/ubuntu1604_x64:${TAG} ubuntu1604_x64 install
./build.sh ${REPO}/ubuntu1604_x64:${TAG} ubuntu1604-cuda_x64 install

./build.sh ${REPO}/centos76_x64:${TAG} centos76_x64 install
./build.sh ${REPO}/centos76_x64:${TAG} centos76-cuda_x64 install

./build.sh ${REPO}/debian105_x64:${TAG} debian105_x64 install
./build.sh ${REPO}/debian105_x64:${TAG} debian105-cuda_x64 install

./build.sh ${REPO}/ubuntu1804_tx2:${TAG} ubuntu1804_tx2 install

./cp-all-builds.sh
