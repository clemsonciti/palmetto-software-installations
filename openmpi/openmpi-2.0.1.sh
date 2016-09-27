#!/bin/bash

wget https://www.open-mpi.org/software/ompi/v2.0/downloads/openmpi-2.0.1.tar.bz2
tar xvf openmpi-2.0.1.tar.bz2
cd openmpi-2.0.1

# GCC 6.1.0 version 
module load gcc/6.1.0
./configure --prefix=/software/openmpi/2.0.1_gcc610 --with-tm=/opt/pbs/default --with-verbs --with-pvfs2=/opt/orangefs --enable-mpi-fortran --enable-mpi-cxx --with-hwloc=/software/hwloc/1.10.1 --with-cuda=/software/cuda-toolkit/7.5.18 --with-io-romio-flags="--with-file-system=pvfs2+ufs+nfs --with-pvfs2=/opt/orangefs"
make
make install

# Intel 16.0 version 
module purge
module load intel/16.0
make clean
./configure --prefix=/software/openmpi/2.0.1_intel160 --with-tm=/opt/pbs/default --with-verbs --with-pvfs2=/opt/orangefs --enable-mpi-fortran --enable-mpi-cxx --with-hwloc=/software/hwloc/1.10.1 --with-cuda=/software/cuda-toolkit/7.5.18 --with-io-romio-flags="--with-file-system=pvfs2+ufs+nfs --with-pvfs2=/opt/orangefs"
make
make install
