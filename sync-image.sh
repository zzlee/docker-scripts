#/bin/sh

IMAGE_SPEC=$1

echo IMAGE_SPEC=${IMAGE_SPEC}

docker tag qcap-registry:5000/${IMAGE_SPEC} yuan88yuan/${IMAGE_SPEC}
docker push qcap-registry:5000/${IMAGE_SPEC}
docker push yuan88yuan/${IMAGE_SPEC}
