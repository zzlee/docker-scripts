#!/bin/sh

docker run --rm -it -p 8080:8080 -p 8080:8080/udp --name sls-server ubuntu1804-zzlee.local:5000/sls-server:v1
