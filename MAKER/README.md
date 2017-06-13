MAKER installation is based on instructions located at the [wq_maker app of CCTools](https://github.com/cooperative-computing-lab/cctools/tree/master/apps/wq_maker)

First, from home directory, we create a parent directory that will contain all of MAKER's core libraries and dependencies. All download and installation steps will happen within the boundary of this directory. 

```
$ cd ~
$ mkdir -p software
$ cd software
```

## Install CCTools.

```
$ git clone https://github.com/cooperative-computing-lab/cctools cctools-source
$ cd cctools-source
$ ./configure --prefix=~/software/cctools
$ make
$ make install
$ export PATH=${HOME}/software/cctools/bin:$PATH
$ cd ..
```

## Instal MAKER and all its required dependencies. 

MAKER can be download from: http://www.yandell-lab.org/software/maker.html.  
The current downloaded version for this guide is 2.31.9. However, CCtools only supports
up to version 2.31.8 at the moment.  

```
$ wget http://yandell.topaz.genetics.utah.edu/maker_downloads/static/maker-2.31.8.tgz
$ tar xzf maker-2.31.8.tar.gz
$ cd maker
$ more INSTALL
```
The followings are the instructions from INSTALL

1.  Go to the .../maker/src/ directory and run 'perl Build.PL' to configure.   

```
$ cd src
$ perl Build.PL
```

2.  Accept default configuration options by just pressing enter. 
 
3.  Run the following commands to install all dependencies and recommended external libraries.

**Note: ** 

- You do not need to be root.  Just say 'Y' to 'local install' when 
running './Build installdeps' and dependencies will be installed under 
.../maker/perl/lib, also missing external tools will be installed under 
.../maker/exe when running './Build installexes'.  

- When you are asked for testing dependencies, you can select **Y** instead of the default **N**. 

- To support automatic installation of RepeatMasker, make sure that you have your RepoBase account and password
ready. 

- Prior to running *./Build installexes*, you will need to modify the `locations` file inside `src` directory. 
This file lists the locations where maker can go and download the external libraries. Run `nano locations` to open
this file. 

- Change the `Linux_x86_64` location of `RepBase` to *'http://www.girinst.org/server/RepBase/protected/repeatmaskerlibraries/RepBaseRepeatMaskerEdition-20170127.tar.gz'* 

- Change the `Linux_x86_64` location of `exonerate` to *'http://ftp.ebi.ac.uk/pub/software/vertebrategenomics/exonerate/exonerate-2.2.0-x86_64.tar.gz'*

- Run the installation steps using `./Build`

```
$ ./Build installdeps
$ ./Build installexes
```

You can check status of dependency installation by running `./Build status`. The outcome should contain 
the followings:

```
==============================================================================
STATUS MAKER v2.31.8
==============================================================================                                                          
PERL Dependencies:      VERIFIED       
External Programs:      VERIFIED 
External C Libraries:   VERIFIED
MPI SUPPORT:            DISABLED 
MWAS Web Interface:     DISABLED 
MAKER PACKAGE:          CONFIGURATION OK
```
Finally, run the MAKER installation

```
$ ./Build install          
```

## Install wq_maker in the bin directory of the MAKER installation.

```
$ cd ../bin
$ wget https://github.com/cooperative-computing-lab/cctools/raw/master/apps/wq_maker/wq_maker
```

- You will need to modify `wq_maker` to point it to the location of the supporting Perl
libraries of CCTools:

```
$ nano wq_maker
```

- Insert the line *use lib '/home/lngo/software/cctools/lib/perl5/site_perl/5.16.3/';* under *user warnings;*
- Type Ctrl-X to exit and select *Y* to save the edited wq_maker file. 
- Export Maker tools:

```
$ export PATH='~/software/maker/bin':$PATH
```

You can test that Maker is now working with wq_maker by listing the command-line options:

```
./wq_maker -h
```
