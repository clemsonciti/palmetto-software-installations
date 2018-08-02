#!/usr/bin/env bash

set -x
set -e

TMP_DIR="$(mktemp -d)"

module add anaconda/5.1.0
module add anaconda3/5.1.0

VIM_VERSION_MAJOR=8
VIM_VERSION_MINOR=1
VIM_VERSION_PATCH=0233
VIM_DOT_VERSION="${VIM_VERSION_MAJOR}.${VIM_VERSION_MINOR}.${VIM_VERSION_PATCH}"

VIM_URL="https://github.com/vim/vim/archive/v${VIM_DOT_VERSION}.tar.gz"
VIM_TAR_FILE="$(basename ${VIM_URL})"

VIM_INSTALL_PREFIX="${HOME}/vim-${VIM_DOT_VERSION}-install"
#VIM_INSTALL_PREFIX="/software/vim/${VIM_DOT_VERSION}"

cd $TMP_DIR

wget -O ${VIM_TAR_FILE} ${VIM_URL}
rm -rf vim-${VIM_DOT_VERSION}

tar -xzf ${VIM_TAR_FILE}

cd vim-${VIM_DOT_VERSION}

## Normal, basic configuration
#./configure --prefix="${VIM_INSTALL_PREFIX}"

# Advanced configuration recommended by YouCompleteMe documentation
./configure \
    --prefix="${VIM_INSTALL_PREFIX}" \
    --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp=yes \
    --enable-pythoninterp=yes \
    --with-python-config-dir=/software/anaconda/5.1.0/lib/python2.7/config \
    --enable-python3interp=yes \
    --with-python3-config-dir=/software/anaconda3/5.1.0/lib/python3.6/config-3.6m-x86_64-linux-gnu \
    --enable-perlinterp=yes \
    --enable-luainterp=yes \
    --enable-gui=auto \
    --enable-cscope

make -j8

make install
#sudo make install

ls -lahR "${VIM_INSTALL_PREFIX}"