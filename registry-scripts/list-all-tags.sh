#!/bin/sh

IMAGE_NAME=$1

curl http://localhost:5000/v2/${IMAGE_NAME}/tags/list
