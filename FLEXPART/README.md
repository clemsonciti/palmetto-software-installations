# FLEXPART

## Installation

~~~
wget https://www.flexpart.eu/downloads/FLEXPART_90.02.tar.gz
wget https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.23.1-Source.tar.gz?api=v2
wget https://www.ece.uvic.ca/~frodo/jasper/software/jasper-1.900.1.zip
~~~

~~~
mkdir FLEXPART-9.02
cp FLEXPART_90.02.tar.gz FLEXPART-9.02
cd FLEXPART-9.02 && tar -xvf *
cd ..
tar -xvf grib*
tar -xvf jasper*
~~~

~~~
module load gcc/5.3.0
cd jasper-1.900.1/
./configure --enable-shared --prefix=/software/FLEXPART/9.02
make -j16
make install
~~~

~~~
cd grib_api-1.23.1-Source/
./configure --with-jasper=/software/FLEXPART/9.02/ --enable-shared --prefix=/software/FLEXPART/9.02
make -j16
make install
~~~

~~~
cd ..
cd FLEXPART-9.02
cp /software/FLEXPART/9.02/include/grib_api.mod .
~~~


In file `erf.f90`, had to change lines

`real, external :: gammln`

to

`real(kind=8), external :: gammln`

Also change `LIBPATHS` and `INCPATHS` in file `makefile.gfs_gfortran`
to `/software/FLEXPART/9.02/lib` and `/software/FLEXPART/9.02/include`.

~~~
make -f makefile.gfs_gfortran 
~~~

Should produce the file `FLEXPART_GFS_GFORTRAN`


## Testing

* Test case: HelloWorld example in https://www.flexpart.eu/wiki/EventsFpTraining2013
* Input files required are provided in "Example meteo files"
* In example folder, change the datetimes in `Options/COMMAND` and `Options/RELEASE`
to datetimes available in the data folder (see `Metfiles/GFS/AVAILABLE`)
* Change `pathnames` file in example folder to appropriate locations. Also need
to add one empty line at the end after `=============`.
* From example folder, run `FLEXPART_GFS_GFORTRAN`
