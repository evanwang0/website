#!/bin/bash -e -x

ssh $ORIGIN -T /bin/bash << EOF
    docker service rm website
    docker secret rm root-tls-key.pem
    docker secret rm root-tls-cert.pem
    docker secret rm www-tls-key.pem
    docker secret rm www-tls-cert.pem
EOF
