---
name: Mathematica
version: 11.1
project: http://www.wolfram.com/mathematica/?source=frontpage-quick-links
---

# Installation

1. Read <https://ccit.clemson.edu/support/faculty-staff/software/individual-licenses/?id=475&l=1>
for details about access to Mathematica
2. Download 
3. `@util01 # ./Mathematica_11.1.1_LINUX.sh` which will ask for the installation directory `/software/mathematica/11.1` and scripts directory `/software/mathematica/11.1/bin`
4. Create a license file `/software/mathematica/11.1/share/Licensing/mathpass`

```
$ cat /software/mathematica/11.1/share/Licensing/mathpass 
!license8.clemson.edu
```

# Module 

Two variables need to be updated 

```
setenv        MATHEMATICA_BASE   /software/mathematica/11.1/share
prepend-path  PATH               /software/mathematica/11.1/bin
```

# Runtime 

With file `Example1.m` that reads

```
Print["Hello World"]
Do[Print[i, " - " , Sin[i]], {i, 0, Pi/2, 0.01}]
Exit[]
```

the batch mode may be used using

```
$ qsub -I
$ cd $PBS_O_WORKDIR
$ module load mathematica/11.1
$ math -noprompt -run '<<Example.m'
```
