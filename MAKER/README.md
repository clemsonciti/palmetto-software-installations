MAKER installation is based on instructions located at the [wq_maker app of CCTools](https://github.com/cooperative-computing-lab/cctools/tree/master/apps/wq_maker)

First, from home directory, we create a parent directory that will contain all of MAKER's core libraries and dependencies. All download and installation steps will happen within the boundary of this directory. 

```
$ cd ~
$ mkdir -p software/maker
$ cd software/maker
```

## Install CCTools.

```
$ git clone https://github.com/cooperative-computing-lab/cctools cctools-source
$ cd cctools-source
$ ./configure --prefix=~/software/maker/cctools
$ make
$ make install
$ export PATH=${HOME}/software/maker/cctools/bin:$PATH
$ cd ..
```

## Instal MAKER and all its required dependencies. 

MAKER can be download from: http://www.yandell-lab.org/software/maker.html. Downloading MAKER is free but requires registration. 
The current downloaded version for this guide is 2.31.9. We first untar MAKER and review the README file. 

```
$ tar xzf maker-2.31.9.tar.gz
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

- You do not need to be root.  Just say 'yes' to 'local install' when 
running './Build installdeps' and dependencies will be installed under 
.../maker/perl/lib, also missing external tools will be installed under 
.../maker/exe when running './Build installexes'.  

- When you are asked for testing dependencies, you can select **Y** instead of the default **N**. 

- To support automatic installation of RepeatMasker, make sure that you have your RepoBase account
ready. 

```
$ ./Build installdeps
$ ./Build installexes
```

4.  If anything fails, either use the ./Build file commands to retry the failed   
section (i.e. './Build installdeps' and './Build installexes') or follow the 
detailed install instructions in the next section to manually install missing                                                                   modules or programs. Use ./Build status to see available commands.           
./Build status           #Shows a status menu                                                                                                   ./Build installdeps      #installs missing PERL dependencies                                                                                    ./Build installexes      #installs missing external programs                                                                                    ./Build install          #installs MAKER                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        Note: For failed auto-download of external tools, when using the command                                                                        './Build installexes', the .../maker/src/locations file is used to identify                                                                     download URLs. You can edit this file to point to any alternate locations.




## Install wq_maker in the bin directory of the MAKER installation.


## Run './wq_maker -g <FASTA_FILE' to annotate sequences in file <FASTA_FILE>.


## Start workers:
work_queue_worker -d all <HOSTNAME> <PORT>
where <HOSTNAME> is the name of the host on which the master is running
	  <PORT> is the port number on which the master is listening.

Alternatively, you can also specify a project name for the master and use that
to start workers:

1. ./wq_maker -g agambiae.fa -N WQMAKER
2. work_queue_worker -d all -N WQMAKER

For listing the command-line options, do:
./wq_maker -h

