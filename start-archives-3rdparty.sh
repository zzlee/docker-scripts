#!/bin/sh

ARCHIVES_HOME=$(pwd)/../archives-3rdparty

echo "Starting archives server @ ${ARCHIVES_HOME}"

cd ${ARCHIVE_HOME} && \
docker run --rm -d --name archives-3rdparty -v "${ARCHIVES_HOME}":/usr/src/app -w /usr/src/app -p 8888:5000 node:8 node server.js
