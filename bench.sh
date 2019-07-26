#!/bin/bash


docker run --privileged --rm -ti \
    -e HPL_N=22000 \
    -e HPL_NB=44 \
    -e HPL_P=1 \
    -e HPL_Q=2 \
    -e MPI_NUM_RANKS=1 \
    -e OMP_NUM_THREADS=2 \
    qnib/plain-linpack-c5xlarge:ubuntu_2019-07-26.1 bench.sh