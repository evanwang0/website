#!/bin/bash -e

docker build -t website:latest .
docker save website:latest | bzip2 | pv | \
ssh $ORIGIN 'bunzip2 | docker load'
ssh $ORIGIN 'docker service update website --image website:latest --force'
