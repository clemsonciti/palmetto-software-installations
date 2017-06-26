#!/bin/bash

module load gcc/7.1.0

# --- Test C ---
cat << EOF > test_c.c
#include <stdio.h>
int main(){
  printf("C test\n");
  return 0;
}
EOF
gcc test_c.c -o test_c.x
./test_c.x > test_c.out
if [ "$?" == 0 ]; then
        echo "SUCCESS [C]"
else
        echo "TERROR ERROR! [C]"
fi

# --- Test C++ ---
cat << EOF > test_cpp.cpp
#include <iostream>
using namespace std;
int main(){
  cout << "C++ test" << endl;
  return 0;
}
EOF
g++ test_cpp.cpp -o test_cpp.x
./test_cpp.x > test_cpp.out
if [ "$?" == 0 ]; then
        echo "SUCCESS [C++]"
else
        echo "TERROR ERROR! [C++]"
fi

# --- Test Fortran ---
cat << EOF > test_f.f90
program test
print *,'Test fortran'
end program test
EOF
gfortran test_f.f90 -o test_f.x
./test_f.x > test_f.out
if [ "$?" == 0 ]; then
        echo "SUCCESS [FORTRAN]"
else
        echo "TERROR ERROR! [FORTRAN]"
fi

# --- Clean ---
rm test_c.{c,x,out}
rm test_cpp.{cpp,x,out}
rm test_f.{f90,x,out}

