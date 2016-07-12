# Installation of LAMMPS on Palmetto cluster

Download the LAMMPS source code from <http://lammps.sandia.gov/download.html>. The detailed 
instruction on usage and compilation options are available here <http://lammps.sandia.gov/doc/Manual.html>.

# Simple build of default packages 

Load modules 

    module load gcc/6.1.0
    module load openmpi/1.10.3
    module load fftw/3.3.4-g481

Unpack and compile the source code

    Date=18Jun16
    tar xf lammps.tar.gz 
    cd lammps-$Date

Download Palmetto Makefile 

    PalmettoMakefile="https://raw.githubusercontent.com/zziolko/palmetto-software-installations/master/lammps/Makefile.palmetto_gcc"
    cd SRC/MAKE/MINE
    wget $PalmettoMakefile
    cd ../..

compile LAMMPS

    make palmetto

After this, directory `lammps-18Jun16/src` should contain file `lmp_palmetto`.

# Building with additional packages

Load modules

    module load gcc/6.1.0
    module load openmpi/1.10.3
    module load fftw/3.3.4-g481

Unpack the source code 

    Date=18Jun16
    tar xf lammps.tar.gz
    cd lammps-$Date

Download Palmetto Makefile

    PalmettoMakefile="https://raw.githubusercontent.com/zziolko/palmetto-software-installations/master/lammps/Makefile.palmetto_gcc" 
    cd SRC/MAKE/MINE
    wget $PalmettoMakefile
    cd ../..

Select packages and proceed with compilation

    make yes-kokkos
    make palmetto KOKKOS_DEVICES=OpenMP

# Building GPU enabled LAMMPS with KOKKOS package 

Load modules

    module load gcc/4.8.1
    module load openmpi/1.8.4
    module load fftw/3.3.4-g481
    module load cuda-toolkit/7.5.18

To use CUDA we need to downgrade GCC since the series 5.x and 6.x are not supported
by the `nvcc` compiler. 

Unpack the source code

    Date=18Jun16
    tar xf lammps.tar.gz
    cd lammps-$Date

Download Palmetto Makefile

    PalmettoMakefile="https://raw.githubusercontent.com/zziolko/palmetto-software-installations/master/lammps/Makefile.palmetto_kokkos_cuda_openmpi"
    cd SRC/MAKE/MINE
    wget $PalmettoMakefile
    cd ../..

Select packages and proceed with compilation

    make yes-kokkos
    make palmetto_kokkos_cuda_openmpi 


