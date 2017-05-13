#!/bin/bash -e

if [[ -n $(git status -s) ]]; then
    echo "$(basename $0): there are uncommited changes - refusing to deploy"
    exit 1
fi

origin=$(echo $1 | cut -d ":" -f 1)
app_dir=$(echo $1 | cut -d ":" -f 2)

git archive --format tar.gz HEAD | ssh $origin $(cat <<EOF
    rm -rf $app_dir &&
    mkdir -p $app_dir &&
    tar -C $app_dir -zxf -
EOF
)

tar -czh -C $2 . | ssh $origin "tar -C $app_dir -zxf -"

ssh $origin -T /bin/bash <<EOF
    cd $app_dir
    docker-compose build
    docker-compose down
    docker-compose up -d
EOF
