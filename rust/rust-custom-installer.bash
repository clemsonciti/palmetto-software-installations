#!/usr/bin/env bash
set -ex

# Custom installation of Rust programming language compiler and
# "cargo" build and dependency management system.
# Designed to be run by users under their account or as root.
# Takes three optional arguments:
# 1) Rust version string
# 2) Install prefix parent dir (which must exist)
# 3) Modulefile parent dir (which also must exist)
#
# This script will attempt to download the version of Rust you specified
# and install the resulting files to default directories or a particular
# place(s) you specified.

# Configurables
RUST_VERSION=${1:-"1.13.0"} # arg1

# THESE DIRECTORIES MUST ALREADY EXIST AND
# BE WRITABLE BY THE USER PERFORMING THE INSTALL!
RUST_PREFIX_PARENT_DEFAULT="$HOME/software"
RUST_MODULEFILE_PARENT_DEFAULT="$HOME/modulefiles"

# These directories will be created by this script or the rust installer script
RUST_PREFIX_PARENT="${2:-$RUST_PREFIX_PARENT_DEFAULT}/rust" # arg2
RUST_PREFIX="$RUST_PREFIX_PARENT/$RUST_VERSION"

RUST_MODULEFILE_PARENT="${3:-$RUST_MODULEFILE_PARENT_DEFAULT}/rust" #arg3
RUST_MODULEFILE="$RUST_MODULEFILE_PARENT/$RUST_VERSION"

# Rust docs
# We will archive these so we can download for safe keeping and use if
# we prefer, rather than copying thousands of files to our NFS based system.
RUST_DOC_FOLDER_NAME='rust-'$RUST_VERSION'-doc'
RUST_DOC_ARCHIVE_NAME="${RUST_DOC_FOLDER_NAME}.tar.gz"

# Create a temporary directory that will get cleaned up on EXIT
# On Palmetto this directory will be created under $TMPDIR. eg:
#   [denton@node0006 ~]$ echo $TMPDIR
#   /local_scratch/pbs.7289979.pbs02
#   [denton@node0006 ~]$ mktemp -du
#   /local_scratch/pbs.7289979.pbs02/tmp.ZHwMcUSL5I
# If run as root on master, the temp dir will be as follows:
#   [root@master ~]# mktemp -du
#   /tmp/tmp.zzuoF2wWmM
MYTMPDIR="$(mktemp -d)"
trap 'rm -rf "$MYTMPDIR"' EXIT

# Where we will unpack rust installer archive and also temporarily install docs
RUST_DIR="$MYTMPDIR/rust/$RUST_VERSION"

ARCHIVES="$HOME/.rust-archives"
RUST_ARCHIVE_NAME='rust-'$RUST_VERSION'-x86_64-unknown-linux-gnu.tar.gz'
RUST_ARCHIVE_PATH="$ARCHIVES/$RUST_ARCHIVE_NAME"
RUST_DOWNLOAD_URL="https://static.rust-lang.org/dist/$RUST_ARCHIVE_NAME"

# Download the Rust installer archive if it doesn't already exist.
if [ ! -r "$RUST_ARCHIVE_PATH" ]; then
  mkdir -p "$ARCHIVES"
  cd "$ARCHIVES"
  wget "$RUST_DOWNLOAD_URL"
  cd -
fi

# Setup working directory under MYTMPDIR
mkdir -p "$RUST_DIR"
cd "$RUST_DIR"
cp "$RUST_ARCHIVE_PATH" .
tar xzf *.tar.gz
cd "rust-${RUST_VERSION}-x86_64-unknown-linux-gnu"
ls -lah

echo "NOTE: The install.sh usage information is as follows:"
./install.sh --help
echo

echo "NOTE: Examine components that may be enabled/disabled:"
./install.sh --list-components
echo

# Ensure that parent directories exist for both installation and modulefile:
mkdir -p "$RUST_PREFIX_PARENT" "$RUST_MODULEFILE_PARENT"

# NOTE: be careful to specify the RUST_PREFIX as the final resting place of
# your rust installation on your system since the binaries are hardcoded to
# look for shared libraries at paths based on the supplied RUST_PREFIX.
./install.sh \
  --prefix="$RUST_PREFIX" \
  --docdir="$RUST_DIR/doc" \
  --disable-ldconfig \
  --verbose \
  2>&1 | tee "${HOME}/rust-${RUST_VERSION}-install.log"
  
cd $RUST_DIR
# Provides a better dir name than "doc" so dir name will match archive name
mv doc $RUST_DOC_FOLDER_NAME
tar czf $RUST_DOC_ARCHIVE_NAME $RUST_DOC_FOLDER_NAME
cp $RUST_DOC_ARCHIVE_NAME $RUST_PREFIX/share

# Generates environment modulefile using a heredoc with variable substitution
# to support future releases of rust.
cat << EOF > "$RUST_MODULEFILE"
#%Module1.0#####################################################################
##
## rust/$RUST_VERSION  modulefile
##
proc ModulesHelp { } {
        global version

        puts stderr "\n\trust/$RUST_VERSION module"
        puts stderr "\t****************************************************"
        puts stderr "\n\t  This module sets up the following environment"
        puts stderr "\t  variables for the rust compiler and cargo:"
        puts stderr "\t      PATH"
        puts stderr "\t      LIBRARY_PATH"
        puts stderr "\t      LD_LIBRARY_PATH"
        puts stderr "\t      MANPATH"
        puts stderr "\n\t  Version $RUST_VERSION\n"
        puts stderr "\t****************************************************\n"
}

conflict rust

module-whatis    "Sets up environment for rustc compiler and cargo."

# for Tcl script use only
set     version      "3.2.6"

prepend-path    PATH                $RUST_PREFIX/bin
prepend-path    LIBRARY_PATH        $RUST_PREFIX/lib
prepend-path    LD_LIBRARY_PATH     $RUST_PREFIX/lib
prepend-path    MANPATH             $RUST_PREFIX/share/man

setenv          RUST_COMPILER_MODULE    "rust/$RUST_VERSION"
setenv          CARGO_MODULE            "rust/$RUST_VERSION"
setenv          RUST_DOC_PATH           "$RUST_PREFIX/share/$RUST_DOC_ARCHIVE_NAME"

if [ module-info mode display ] {
        ModulesHelp
}

EOF

echo "INSTALLATION COMPLETED SUCCESSFULLY!"