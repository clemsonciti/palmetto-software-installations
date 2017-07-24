---
name: FreeFem++
version: 3.56
project: http://www.freefem.org/
source: http://www.freefem.org/ff++/ftp/freefem++-3.56.tar.gz
---

# Compilation 

```
wget http://www.freefem.org/ff++/ftp/freefem++-3.56.tar.gz
tar xvf freefem++-3.56.tar.gz
cd freefem++-3.56

module load intel/17.0
module load openmpi/1.10.3
module load hdf5/1.10.1

./configure --prefix=/software/freefem++/3.56 \
  --enable-mkl-mlt \
  --disable-openblas 
make -j 8
make install

```

# Module file 

```
prepend-path	PATH			/software/freefem++/3.56/bin
prepend-path	LD_LIBRARY_PATH		/software/freefem++/3.56/lib
```

# Test 

```
qsub -I
wget https://people.sc.fsu.edu/~jburkardt/freefem++/array2d/array2d.edp
module load freefem++/3.56
FreeFem++ -ng array2d.edp
```
