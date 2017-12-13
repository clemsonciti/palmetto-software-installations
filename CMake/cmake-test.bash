#!/usr/bin/env bash

major=3
minor=10
patch=0
version=${major}.${minor}.${patch}

module add gcc
module add cmake/${major}.${minor}.${patch}

tmp_dir=$(mktemp -d)

function finish {
  rm -rf ${tmp_dir}
}
trap finish EXIT

set -x

cd ${tmp_dir}


# This example is inspired by and heavily draws from the following article:
#    https://mirkokiefer.com/cmake-by-example-f95eb47d45b1

cat << EOF > CMakeLists.txt
cmake_minimum_required(VERSION ${version})
project(simple_app_project)
add_executable(hello-world hello-world.c)
install(TARGETS hello-world DESTINATION bin)
EOF

# Now script the creation of the source code that will be built by cmake
cat << EOF > hello-world.c
#include <stdio.h>
int main(){
    printf("Hello world.\n");
    return 0;
}
EOF

# Setup and execute the build
mkdir _build
cd _build
cmake .. -DCMAKE_INSTALL_PREFIX=../_install
make
make install

# Execute the application built by cmake
../_install/bin/hello-world

# Uncomment the following line if you would like to perform a recurive
# ls on the tmp_dir prior to its removal.

#cd ..; ls -lahR
