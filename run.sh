#!/bin/bash -e

trap teardown EXIT

function teardown() {
    sed -i "" "/evanwang0\.com/d" /etc/hosts
    docker-compose down
}

cat <<EOF >> /etc/hosts
127.0.0.1  evanwang0.com
::1        evanwang0.com
127.0.0.1  www.evanwang0.com
::1        www.evanwang0.com
EOF

docker-compose build --pull
docker-compose up
