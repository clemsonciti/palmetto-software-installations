
# Samtools

Download a release: https://sourceforge.net/projects/samtools/files/

~~~
$ wget https://sourceforge.net/projects/samtools/files/samtools/1.4/samtools-1.4.tar.bz2/download -O samtools-1.4.tar.bz2
~~~

Unzip the `.bz2` file:

~~~
$ tar -xvf samtools-1.4.tar.bz2
~~~

Add XZ tools to environment:

~~~
$ export LD_LIBRARY_PATH=/software/xz/5.2.3/lib:$LD_LIBRARY_PATH
$ export LIBRARY_PATH=$LD_LIBRARY_PATH
$ export C_INCLUDE_PATH=/software/xz/5.2.3/include:$LD_LIBRARY_PATH
$ export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH
$ export PATH=/software/xz/5.2.3/bin:$PATH
~~~

~~~
$ cd samtools
$ ./configure --prefix=/path/to/install --disable-bz2
$ make
$ make install
~~~

