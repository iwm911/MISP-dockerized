#!/bin/bash
set -ex

DOCKER_REPO="$1"
tag="$2"
[ -z $(echo $tag|grep dev) ] && tag="$tag-dev"
image_id=$(docker images --format "{{.Repository}}:{{.Tag}}:{{.ID}}"|grep $DOCKER_REPO:$tag|cut -d : -f 3|head -n 1;)
image_tags=$(docker images --format "{{.Repository}}:{{.Tag}}:{{.ID}}"|grep $image_id|cut -d : -f 2;)
for i in $image_tags
do
    k=$(echo $i|sed 's,-dev$,,')
    docker tag $DOCKER_REPO:$i $DOCKER_REPO:$k; \
done
