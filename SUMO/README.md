MAKER installation is based on instructions located at the [wq_maker app of CCTools](https://github.com/cooperative-computing-lab/cctools/tree/master/apps/wq_maker)

First, from home directory, we create a parent directory that will contain all of MAKER's core libraries and dependencies. All download and installation steps will happen within the boundary of this directory. 

```
 822  cd gdal-2.2.0/
  823  make
  824  make install
  825  cd ~/tmp/
  826  tar xzf proj-4.9.3.tar.gz
  827  cd proj-4.9.3/
  828  ./configure --prefix=$HOME/software/proj/4.9.3
  829  make
  830  make install
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
