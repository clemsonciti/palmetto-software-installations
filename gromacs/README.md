---
name: GROMACS
version: 2016.3
project: http://www.gromacs.org/
installation: http://manual.gromacs.org/documentation/2016.3/install-guide/index.html
---

# Compilation

Lets start with the interactive session with GPUs and 20 cores for things to get quickly

```
$ qsub -I -l select=1:ncpus=20:mem=50gb:ngpus=2,
	walltime=2:00:00
$ cd $TMPDIR
```

Enabling hwloc (enabled by default if detected causes error during the build). Option `-DGMX_HWLOC=off` turns off the hwloc support. 

The configuration below is designed for GPU nodes which also include AVX extensions in the CPU. The code will not work in the phases older than phase 7 since those CPUs do not support AVX SIMD instructions. 

```
$ mkdir gromacs-build
$ cd gromacs-build
$ wget http://ftp.gromacs.org/pub/gromacs/gromacs-2016.3.tar.gz
$ tar xvf gromacs-2016.3.tar.gz
$ cd gromacs-2016.3

$ module load cmake/3.6.1
$ module load intel/16.0
$ module load cuda-toolkit/8.0.44

$ mkdir build
$ cd build
$ cmake -DCMAKE_INSTALL_PREFIX=$HOME/gromacs -DGMX_FFT_LIBRARY=mkl -DGMX_MPI=on -DGMX_GPU=on -DGMX_SIMD=AVX_256 -DGMX_CUDA_TARGET_COMPUTE=35 -DGMX_HWLOC=off ..\
$ make -j 20
$ make install 
```

# Testing

Testing using the GROMACS regression testing suite 

```
$ wget http://gerrit.gromacs.org/download/regressiontests-2016.3.tar.gz
$ tar xvf regressiontests-2016.3.tar.gz
$ cd regressiontests-2016.3
```

Load the shell setting and set number of OpenMP threads to 1 since not all tests may be run with thread support. 

```
$ source $HOME/gromacs/bin/GMXRC.bash
$ export OMP_NUM_THREADS=1
```

Run the tests on a single MPI process, clean the results and run again using 20 MPI processes. 

```
$ ./gmxtest.pl simple -np 1
$ ./gmxtest.pl clean
$ ./gmxtest.pl simple -np 20
```

