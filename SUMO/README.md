Sumo installation is based on instructions located at the [Sumo Traffic Simulator](http://sumo.dlr.de/wiki/Installing/Linux_Build)

## Preperation

```
cd ~
mkdir -p software
mkdir -p tmp
```

## Install dependencies


### fox

```
cd ~/tmp
wget ftp://ftp.fox-toolkit.org/pub/fox-1.6.55.tar.gz
tar xzf fox-1.6.55.tar.gz
cd fox-1.6.55/
./configure --prefix=/$HOME/software/fox/1.6.55
make
make install
```

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

### xerces

```
cd ~/tmp
wget http://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.4.tar.gz
tar xzf xerces-c-3.1.4.tar.gz
cd xerces-c-3.1.4/
./configure --prefix=$HOME/software/xerces-c/3.1.4
make
make install
```
  
## Install SUMO
  
```
cd ~/tmp/
svn co https://svn.code.sf.net/p/sumo/code/trunk/sumo
cd sumo
make -f Makefile.cvs
./configure --prefix=$HOME/software/sumo/0.30.0 --with-fox-config=$HOME/software/fox/1.6.55/bin/fox-config --with-proj-gdal=$HOME/software/gdal/2.2.0 --with-xerces=$HOME/software/xerces-c/3.1.4
make
make install
```
