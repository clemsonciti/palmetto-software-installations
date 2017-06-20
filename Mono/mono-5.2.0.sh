#!/bin/bash

name=mono
version=5.2.0
subversion=179
web=https://download.mono-project.com/sources/$name/$name-$version.$subversion.tar.bz2
wget $web

tar jxvf $name-$version.$subversion.tar.bz2
cd $name-$version.$subversion
module load cmake/3.6.1
./configure --prefix=/software/$name/$version
make 
make install

