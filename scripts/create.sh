#!/bin/bash -e -x

docker build -t website:latest .
docker save website:latest | bzip2 | pv | ssh $ORIGIN 'bunzip2 | docker load'

cat $ROOT_TLS_KEY | ssh $ORIGIN 'docker secret create root-tls-key.pem -'
cat $ROOT_TLS_CERT | ssh $ORIGIN 'docker secret create root-tls-cert.pem -'

cat $WWW_TLS_KEY | ssh $ORIGIN 'docker secret create www-tls-key.pem -'
cat $WWW_TLS_CERT | ssh $ORIGIN 'docker secret create www-tls-cert.pem -'

ssh $ORIGIN -T /bin/bash << EOF
    docker service create \
        --name website \
        --secret root-tls-key.pem \
        --secret root-tls-cert.pem \
        --secret www-tls-key.pem \
        --secret www-tls-cert.pem \
        -e ROOT_TLS_KEY=/run/secrets/root-tls-key.pem \
        -e ROOT_TLS_CERT=/run/secrets/root-tls-cert.pem \
        -e WWW_TLS_KEY=/run/secrets/www-tls-key.pem \
        -e WWW_TLS_CERT=/run/secrets/www-tls-cert.pem \
        -p 443:8443 \
        website:latest
EOF
