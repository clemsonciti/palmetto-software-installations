#!/bin/bash

name=gcc
version=5.4.0
web=http://mirrors.concertpass.com/$name/releases/$name-$version/$name-$version.tar.bz2
wget $web

tar jxvf $name-$version.tar.bz2
cd $name-$version
mkdir build
cd build
../configure --prefix=/software/$name/$version --enable-languages=c,c++,fortran --enable-lto --disable-multilib
make 
make install

