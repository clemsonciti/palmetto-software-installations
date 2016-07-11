# Installation of OpenMPI on Palmetto

Download OpenMPI and unpack the source code

~~~
wget https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.3.tar.bz2
tar xvf openmpi-1.10.3.tar.bz2
cd openmpi-1.10.3
~~~

OpenMPI in versions higher than 1.8.x will not support Myrinet network. Large
fraction of Palmetto nodes include that interconnection and need to use 1.8.x 
series to use Myrinet network. Higher versions need to use Ethernet. 

Load modules needed to build all desired features

~~~
module load gcc/6.1.0
module load hwloc/1.10.1
module load cuda-toolkit/7.5.18
~~~

Configure and build

~~~
 ./configure --prefix=/software/openmpi/1.10.3 --with-tm=/opt/pbs/default --with-verbs --with-pvfs2=/opt/orangefs --enable-mpi-fortran --enable-mpi-cxx --with-hwloc=/software/hwloc/1.10.1 --with-cuda=/software/cuda-toolkit/7.5.18 --with-io-romio-flags="--with-file-system=pvfs2+ufs+nfs --with-pvfs2=/opt/orangefs"
make 
make install
~~~

The Fortran MPI support is provided two ways 1) via `mpif.h` file (compiler independent) and 
2) `mpi.mod` file (compiler dependent). The second option will restrict the module to be compiler
and in case of GCC also version specific. 

Flags

`--with-tm` - support for scheduler (PBS on Palmetto)
`--with-hwloc` - support for hardware locality program
`--with-cuda` - GPU aware configuration, support for RDMA
`--with-pvfs2` - support for OrangeFS (/scratch1) 

