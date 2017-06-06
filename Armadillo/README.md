# Using GCC and OpenBLAS

~~~
wget http://sourceforge.net/projects/arma/files/armadillo-7.950.0.tar.xz
tar -xvf armadillo-7.950.0.tar.xz
cd armadillo-7.950.0/
module add openblas
~~~

Edit the file `cmake_aux/Modules/ARMA_FindOpenBLAS.cmake` and add
`/software/openblas/lib` to the `CMAKE_SYSTEM_LIBRARY_PATH`.

~~~
cmake -DCMAKE_INSTALL_PREFIX=/software/armadillo/7.950.0 .
make
mkdir build
make install PREFIX=`pwd`/build
~~~
