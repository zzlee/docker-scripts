#/bin/sh

./clean-all-builds.sh

./build.sh hisiv hi3531a install
./build.sh hisiv hi3531a400 install
./build.sh hisiv510 hi3531a510 install
./build.sh hisiv hi3531d install
./build.sh hisiv hi3519a install
./build.sh hisiv hi3559a install

./build.sh ubuntu1804_x64 ubuntu1804_x64 install
./build.sh ubuntu1804_x64 ubuntu1804-cuda_x64 install

./build.sh ubuntu1604_x64 ubuntu1604_x64 install
./build.sh ubuntu1604_x64 ubuntu1604-cuda_x64 install

./build.sh centos76_x64 centos76_x64 install
./build.sh centos76_x64 centos76-cuda_x64 install

./build.sh debian105_x64 debian105_x64 install
./build.sh debian105_x64 debian105-cuda_x64 install

./build.sh ubuntu1804_tx2 ubuntu1804_tx2 install

./cp-all-builds.sh