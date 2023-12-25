#!/bin/sh

docker run --rm -it -p 8080:8081 -p 8080:8081/udp --name sls-server yuan88yuan/sls-server:v1
