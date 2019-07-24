#!/bin/bash

: "${OMP_PROC_BIND:=TRUE}"
: "${OMP_PLACES:=cores}"

if [[ "X${HPL_ENV_FILE}" == "X" ]];then
    echo '!! Please provide environment file to source  via environment $HPL_ENV_FILE (eg. r2700x.sh)'
    exit 1

fi
echo ">> Source $HPL_ENV_FILE"
source $HPL_ENV_FILE
echo ">> N=${HPL_N} / NB=${HPL_NB} / P=${HPL_P} / Q=${HPL_Q}"
echo ">> OMP_NUM_THREADS=${OMP_NUM_THREADS} / MPI_NUM_RANKS=${MPI_NUM_RANKS}"

echo ">> Update HPL.dat"
confd -onetime -backend env

echo ">> mpirun --allow-run-as-root -np ${MPI_NUM_RANKS} --map-by l3cache --mca btl self,vader xhpl"
mpirun --allow-run-as-root -np ${MPI_NUM_RANKS} --map-by l3cache --mca btl self,vader xhpl
exit 0
