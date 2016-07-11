#!/bin/bash

# Installation of Quantum Espresso 5.4.0

# Non-GPU build
# Create build directory

mkdir -p qe-tmp/src
cd qe-tmp/src

# Download all source packages for Quantum Espresso 5.4.0

wget http://qe-forge.org/gf/download/frsrelease/211/972/QE-GPU-5.4.0.tar.gz
wget http://qe-forge.org/gf/download/frsrelease/211/968/espresso-5.4.0.tar.gz
wget http://qe-forge.org/gf/download/frsrelease/211/969/EPW-5.4.0.tar.gz
wget http://qe-forge.org/gf/download/frsrelease/211/954/atomic-5.4.0.tar.gz
wget http://qe-forge.org/gf/download/frsrelease/211/957/GWW-5.4.0.tar.gz
wget http://qe-forge.org/gf/download/frsrelease/211/958/xspectra-5.4.0.tar.gz
wget http://qe-forge.org/gf/download/frsrelease/211/961/PWgui-5.4.0.tar.gz
wget http://qe-forge.org/gf/download/frsrelease/211/962/PHonon-5.4.0.tar.gz
wget http://qe-forge.org/gf/download/frsrelease/211/956/tddfpt-5.4.0.tar.gz
wget http://qe-forge.org/gf/download/frsrelease/211/959/neb-5.4.0.tar.gz
wget http://qe-forge.org/gf/download/frsrelease/211/960/pwcond-5.4.0.tar.gz
wget http://qe-forge.org/gf/download/frsrelease/211/963/test-suite-5.4.0.tar.gz


# organize and unpack all packages. Main package `espresso-5.4.0.tar.gz` needs to
# be unpacked first and all others need to be unpacked in the `espresso-5.4.0` directory.

tar xvf espresso-5.4.0.tar.gz
mkdir archives
mv espresso-5.4.0.tar.gz archives
cp *.gz espresso-5.4.0
mv *.gz archives
cd espresso-5.4.0

list=$(ls *.gz)
for i in $list
do
  tar xvf $i
  rm $i
done

# Load compiler module and MPI package
module load gcc/4.8.1
module load openmpi/1.10.3
module load fftw/3.3.4-g481
module load scalapack/2.0.2

# Make sure that the optimized version of BLAS and LAPACK will be found by the
# configure program. Quantum Espresso will use the variables `BLAS_LIBS` and `LAPACK_LIBS`
# to find them

export BLAS_LIBS="-L/software/intel/parallel_studio_xe_2016.2.062/compilers_and_libraries_2016/linux/mkl/lib/intel64/ -lmkl_rt"
export LAPACK_LIBS="-L/software/intel/parallel_studio_xe_2016.2.062/compilers_and_libraries_2016/linux/mkl/lib/intel64/ -lmkl_rt"

# Configure and build
./configure --enable-parallel --with-scalapack
make all

# GPU enabled build
# In addition to the above, add `cuda-toolkit` module

module load cuda-toolkit/7.5.18

# and run the GPU package `configure` script

cd GPU
./configure --enable-parallel --with-scalapack --enable-cuda --with-gpu-arch=sm_35 --with-cuda-dir=/software/cuda-toolkit/7.5.18 --without-magma --with-phigemm
cd ..
make -f Makefile.gpu pw-gpu

# The `bin` directory should now contain `pw-gpu.x` file.
