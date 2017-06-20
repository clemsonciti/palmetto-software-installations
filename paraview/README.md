## Paraview

Paraview is super picky about versions of dependencies it can work
with. 

~~~
[atrikut@node0568 local_scratch]$ tar -xvf ParaView-v5.3.0.tar.gz 
[atrikut@node0568 local_scratch]$ cd ParaView-v5.3.0/
[atrikut@node0568 local_scratch]$ mkdir Build && cd Build
[atrikut@node0568 Build]$ module add gcc/4.8.1 openmpi/1.8.1 cmake/3.6.1 ffmpeg/3.3.2 python/2.7.13 Qt/4.8.5
[atrikut@node0568 Build]$ ccmake ..
~~~

**Note**: Paraview 5.4 and up need Qt 5.9 (not currently installed).

Configure iteratively. May need to point at location of FFMPEG_ROOT.
After generating Makefiles:

~~~
$ make -j24
~~~

To run `make install` on a different node,
run the last line in the output of:

~~~
$ make install --just-print
~~~

