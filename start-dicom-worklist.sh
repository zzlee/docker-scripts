#~/bin/sh

PORT=8104
WORKLIST_DB=`pwd`/WorklistDB

docker run -p ${PORT}:104 --rm -d \
	-v ${WORKLIST_DB}:/etc/WorklistDB \
	--name dicom-worklist \
	--entrypoint /usr/bin/wlmscpfs \
	yuan88yuan/dcmtk:v1 -dfr -dfp /etc/WorklistDB 104 $@

