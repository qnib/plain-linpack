#!/bin/bash

DATE=$(date +%F).1

#echo ">> Build generic ubuntu base"
#docker build -t qnib/plain-linpack-base:ubuntu_${DATE} \
#    -f=docker/dfiles/base/Dockerfile.ubuntu \
#    ./docker/
#
#echo ">> Build ubuntu middlelayer"
#docker build -t qnib/plain-linpack-libs:ubuntu_${DATE} \
#   -f=docker/dfiles/base/Dockerfile.generic \
#    --build-arg=CFLAGS_MARCH=skylake \
#    --build-arg=BLAS_TARGET=SKYLAKEX \
#    --build-arg=FROM_IMG_TAG=${DATE} \
#    docker

echo ">> Build ubuntu hpl"
docker build -t qnib/plain-linpack-hpl:ubuntu_${DATE} \
    -f=docker/dfiles/arch/intel/Dockerfile.generic \
    --build-arg=CFLAGS_MARCH=skylake \
    --build-arg=FROM_IMG_TAG=${DATE} \
    docker

for x in c5xlarge;do
    echo ">> Build ubuntu c5xlarge image"
    docker build -t qnib/plain-linpack-${x}:ubuntu_${DATE} \
        -f=docker/dfiles/env/Dockerfile.${x} \
        --build-arg=FROM_IMG_TAG=${DATE} \
        docker
done