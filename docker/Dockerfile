ARG DOCKER_REGISTRY=docker.io
ARG FROM_IMG_REPO=qnib
ARG FROM_IMG_NAME="uplain-init"
ARG FROM_BASE_TAG="bionic-20190612"
ARG FROM_IMG_TAG="2019-07-11"
ARG FROM_IMG_HASH=""
FROM ${DOCKER_REGISTRY}/${FROM_IMG_REPO}/${FROM_IMG_NAME}:${FROM_BASE_TAG}_${FROM_IMG_TAG}${DOCKER_IMG_HASH} AS build

ARG NUM_THREADS=2
ARG CFLAGS_MARCH="core2"
ARG CFLAGS_OPT="fast"

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt-get update \
 && apt-get install -y build-essential hwloc libhwloc-dev libevent-dev autoconf automake gfortran
ENV CFLAGS="-O${CFLAGS_OPT} -march=${CFLAGS_MARCH}" 
RUN apt-get install -y wget ca-certificates
## OpenMPI
WORKDIR /usr/local/src/openmpi
RUN wget -qO- https://download.open-mpi.org/release/open-mpi/v3.1/openmpi-3.1.4.tar.bz2 \
 |tar xfj - -C . --strip-components=1
## TODO: Enable PMI
RUN echo ">> CFLAGS=${CFLAGS}" \
 && echo ">> ./configure --prefix=/usr/local/ && make -j ${NUM_THREADS} && make install " \
 && ./configure --prefix=/usr/local/openmpi \
 && make -j ${NUM_THREADS} \
 && make install
ENV MPI_HOME=/usr/local/openmpi
ENV PATH=$PATH:$MPI_HOME/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MPI_HOME/lib
COPY src/simple-mpi-test.c /usr/local/src/
RUN mpicc -o /usr/local/bin/simple-mpi-test /usr/local/src/simple-mpi-test.c
RUN apt-get install -y openssh-client
RUN mpirun --allow-run-as-root -np 2 /usr/local/bin/simple-mpi-test

## BLAS
WORKDIR /usr/local/mkl 
ARG MKL_VER=2019.3.199
RUN apt-get -y install cpio
RUN wget -qO- http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/15275/l_mkl_${MKL_VER}.tgz |tar xfz - --strip-components=1
RUN sed -i 's/ACCEPT_EULA=decline/ACCEPT_EULA=accept/g' silent.cfg \
 && sed -i 's/ARCH_SELECTED=ALL/ARCH_SELECTED=INTEL64/g' silent.cfg \
 && sed -i 's/COMPONENTS=DEFAULTS/COMPONENTS=;intel-comp-l-all-vars__noarch;intel-comp-nomcu-vars__noarch;intel-openmp__x86_64;intel-tbb-libs__x86_64;intel-mkl-common__noarch;intel-mkl-installer-license__noarch;intel-mkl-core__x86_64;intel-mkl-core-rt__x86_64;intel-mkl-doc__noarch;intel-mkl-doc-ps__noarch;intel-mkl-gnu__x86_64;intel-mkl-gnu-rt__x86_64;intel-mkl-common-ps__noarch;intel-mkl-core-ps__x86_64;intel-mkl-common-c__noarch;intel-mkl-core-c__x86_64;intel-mkl-common-c-ps__noarch;intel-mkl-tbb__x86_64;intel-mkl-tbb-rt__x86_64;intel-mkl-gnu-c__x86_64;intel-mkl-common-f__noarch;intel-mkl-core-f__x86_64;intel-mkl-gnu-f-rt__x86_64;intel-mkl-gnu-f__x86_64;intel-mkl-f95-common__noarch;intel-mkl-f__x86_64;intel-mkl-psxe__noarch;intel-psxe-common__noarch;intel-psxe-common-doc__noarch;intel-compxe-pset/g' silent.cfg
RUN  ./install.sh -s silent.cfg && \
  cd .. && rm -rf * && \
  rm -rf /opt/intel/.*.log /opt/intel/compilers_and_libraries_2019.3.199/licensing && \
  echo "/opt/intel/mkl/lib/intel64" >> /etc/ld.so.conf.d/intel.conf && \
  ldconfig
 