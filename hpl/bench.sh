#!/bin/bash

: "${OMP_PROC_BIND:=TRUE}"
: "${OMP_PLACES:=cores}"
: "${OMP_NUM_THREADS:=4}"
: "${MPI_NUM_RANKS:=4}"

echo ">> mpirun --allow-run-as-root -np ${MPI_NUM_RANKS} --map-by l3cache --mca btl self,vader xhpl"
mpirun --allow-run-as-root -np ${MPI_NUM_RANKS} --map-by l3cache --mca btl self,vader xhpl