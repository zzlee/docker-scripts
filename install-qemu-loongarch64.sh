#!/bin/sh

magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x02\x01'
mask='\xff\xff\xff\xff\xff\xff\xff\xfc\x00\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
family=loongarch
#qemu=/usr/libexec/qemu-binfmt/loongarch64-binfmt-P
qemu=/bin/qemu-loongarch64
flags="OC"

#ln ../../bin/qemu-loongarch64 $qemu -fs
echo ":qemu-loongarch64:M::$magic:$mask:$qemu:$flags" > /proc/sys/fs/binfmt_misc/register

