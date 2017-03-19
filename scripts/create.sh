#!/bin/bash -e -x

docker build -t website:latest .
docker save website:latest | bzip2 | pv | ssh $ORIGIN 'bunzip2 | docker load'

cat $ORIGIN_TLS_KEY | ssh $ORIGIN 'docker secret create origin-tls-key.pem -'
cat $ORIGIN_TLS_CERT | ssh $ORIGIN 'docker secret create origin-tls-cert.pem -'

ssh $ORIGIN -T /bin/bash << EOF
    docker service create \
        --name website \
        --secret origin-tls-key.pem \
        --secret origin-tls-cert.pem \
        -e WEBSITE_TLS_KEY=/run/secrets/origin-tls-key.pem \
        -e WEBSITE_TLS_CERT=/run/secrets/origin-tls-cert.pem \
        -p 443:8443 \
        website:latest
EOF
