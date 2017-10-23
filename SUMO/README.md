Sumo installation is based on instructions located at the [Sumo Traffic Simulator](http://sumo.dlr.de/wiki/Installing/Linux_Build)

## Preperation

```
cd ~
mkdir -p software
mkdir -p tmp
```

## Install dependencies

### gdal

```
cd ~/tmp
wget http://download.osgeo.org/gdal/2.2.0/gdal-2.2.0.tar.gz
tar xzf gdal-2.2.0.tar.gz
cd gdal-2.2.0/
./configure --prefix=/$HOME/software/gdal/2.2.0
make
make install
```

### proj

```
cd ~/tmp/
wget http://download.osgeo.org/proj/proj-4.9.3.tar.gz
tar xzf proj-4.9.3.tar.gz
cd proj-4.9.3/
./configure --prefix=$HOME/software/proj/4.9.3
make
make install
```

831  cd ~/tmp
  832  tar xzf xerces-c-3.1.4.tar.gz
  833  cd xerces-c-3.1.4/
  834  more INSTALL
  835  ls
  836  autoconf
  837  ls
  838  export XERCESCROOT='/home/lngo/tmp/xerces-c-3.1.4'
  839  cd $XERCESCROOT
  840  cd src/xercesc/
  841  ls
  842  autoconf
  843  cd ..
  844  module avail
  845  cd ..
  846  ls
  847  ./configure --prefix=$HOME/software/xerces-c/3.1.4
  848  make
  849  make install
  ```
  
  ## Install SUMO
  
  ```
  850  cd ~/tmp/
  851  ls
  852  svn
  853  svn co https://svn.code.sf.net/p/sumo/code/trunk/sumo
  854  cd sumo
  855  ls
  856  make -f Makefile.cvs
  857  ld
  858  ls
  859  ./configure --prefix=$HOME/software/sumo/0.30.0 --with-fox-config=$HOME/software/fox/1.6.54/bin/fox-config --with-proj-gdal=$HOME/software/gdal/2.2.0 --with-xerces=$HOME/software/xerces-c/3.1.4
  860  ./configure --help
  861  
  862  make
  863  make install
  864  ls
```
