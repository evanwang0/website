#!/bin/bash

docker build -t website:latest .
docker save website:latest | bzip2 | pv | \
ssh $ORIGIN 'bunzip2 | docker load'
ssh $ORIGIN 'docker rm -f website'
ssh $ORIGIN 'docker run --name website -d -p 80:8080 website:latest npm start'
