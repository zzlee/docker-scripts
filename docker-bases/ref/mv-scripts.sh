#!/bin/sh

TARGET=$1

mkdir ${TARGET} -p
cp mkfiles/${TARGET}.mk ${TARGET}/
cp build-scripts/ ${TARGET} -r
find ${TARGET}/build-scripts/ -name "*.sh" -exec rm {} \;
find build-scripts/ -name "build_${TARGET}.sh" -exec cp {} ${TARGET}/{} \;
cp build-scripts/ffmpeg/module_vars.sh ${TARGET}/build-scripts/ffmpeg/
