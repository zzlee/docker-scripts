#!/bin/sh

docker run --rm -d -p 5000:5000 -v $(pwd)/registry:/var/lib/registry --name registry registry:2