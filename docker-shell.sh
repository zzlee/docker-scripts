#!/bin/bash

IMAGE=$1

./docker-run.sh ${IMAGE} "su - ${SUDO_USER}"
