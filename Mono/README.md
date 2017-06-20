---
name: mono
version: 5.2.0
project: http://www.mono-project.com/
dependencies: none
build: cmake, gcc (OL7.3)
---

# Installation

```
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
```

# Module file 

Module file requires only export of `PATH` and `LD_LIBRARY_PATH` variables. 

```
prepend-path  PATH     /software/mono/5.2.0/bin
prepend-path  LD_LIBRARY_PATH  /software/mono/5.2.0/lib
```

# Compilation and runtime 

With a file `hello.cs`

```
// Hello1.cs
public class Hello1
{
   public static void Main()
   {
      System.Console.WriteLine("Hello, World!");
   }
}
```

use 

```
$ module load mono/5.2.0
$ mcs hello.cs
$ mono hello.exe 
Hello, World!
```
