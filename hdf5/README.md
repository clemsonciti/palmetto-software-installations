---
name: HDF5
version: 1.10.1
project: https://www.hdfgroup.org/
source: https://www.hdfgroup.org/downloads/hdf5/source-code/
---

# Compilation 

```
tar xvf hdf5-1.10.1.tar.gz
cd hdf5-1.10.1

module load intel/17.0
module load openmpi/1.10.3

LIBS="-lcrypto -lssl" CC=mpicc CXX=mpicxx FC=mpif90 ./configure \
  --enable-parallel \
  --prefix=/software/hdf5/1.10.1 \
  --enable-cxx \
  --enable-fortran \
  --enable-build-mode=production \
  --enable-unsupported 
make -j 8
make install
```

Flags `--enable-cxx` and `--enable-parallel` are in conflict but 
`--enable-unsupported`. The compilation of tests requires linking to
`libpbs` and SSL specific functions (hence LIBS="-lcrypto -lssl").  

# Module file 

```
prepend-path  PATH             "/software/hdf5/1.10.1/bin"
prepend-path  INCLUDE_PATH     "/software/hdf5/1.10.1/include"
prepend-path  C_INCLUDE_PATH   "/software/hdf5/1.10.1/include"
prepend-path  LIBRARY_PATH     "/software/hdf5/1.10.1/lib"
prepend-path  LD_LIBRARY_PATH  "/software/hdf5/1.10.1/lib"
```

# Test  

```
$ qsub -I
$ wget https://support.hdfgroup.org/ftp/HDF5/current/src/unpacked/examples/h5_crtdat.c
$ module load intel/17.0
$ module load openmpi/1.10.3
$ module load hdf5/1.10.1
$ h5pcc h5_crtdat.c -o test.x
$ ./test.x 
$ h5dump dset.h5 
HDF5 "dset.h5" {
GROUP "/" {
   DATASET "dset" {
      DATATYPE  H5T_STD_I32BE
      DATASPACE  SIMPLE { ( 4, 6 ) / ( 4, 6 ) }
      DATA {
      (0,0): 0, 0, 0, 0, 0, 0,
      (1,0): 0, 0, 0, 0, 0, 0,
      (2,0): 0, 0, 0, 0, 0, 0,
      (3,0): 0, 0, 0, 0, 0, 0
      }
   }
}
}
```
