#~/bin/sh

HTTP_PORT=8042
PACS_PORT=4242
CONFIG_FILE=`pwd`/orthanc.json

docker run -p ${PACS_PORT}:4242 -p ${HTTP_PORT}:8042 --rm \
	-v ${CONFIG_FILE}:/etc/orthanc/orthanc.json \
	jodogne/orthanc-plugins
