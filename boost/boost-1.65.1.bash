#!/usr/bin/env bash

set -e
set -x

major=1
minor=65
patch=1

boost_dl_url="https://dl.bintray.com/boostorg/release/${major}.${minor}.${patch}/source/boost_${major}_${minor}_${patch}.tar.gz"
boost_archive="$(basename ${boost_dl_url})"
boost_folder="$(basename ${boost_dl_url} .tar.gz)"

boost_install_folder=/software/boost/${major}.${minor}.${patch}
boost_modulefile=/software/modulefiles/boost/${major}.${minor}.${patch}


tmp_dir=$(mktemp -d)

function finish {
  rm -rf ${tmp_dir}
}
trap finish EXIT

cd ${tmp_dir}
wget ${boost_dl_url}

printf "You must confirm the following hash matches the provided hash on boost download site!\n"
printf "\n\tThe hash is: %s\n\n" "$(/usr/bin/sha256sum ${boost_archive})"

tar xzf ${boost_archive}
mv ${boost_folder} ${boost_install_folder}
chown --recursive root:root ${boost_install_folder}


# Now, setup the modulefile
cat << EOF > ${boost_modulefile}
#%Module1.0
##
## boost/${major}.${minor}.${patch}  modulefile
##
proc ModulesHelp { } {
    puts stderr "boost/${major}.${minor}.${patch} - sets the environment for BOOST ${major}.${minor}.${patch}"
}

module-whatis   "sets the environment for BOOST ${major}.${minor}.${patch}"

module add mpfi/1.5.1

prepend-path C_INCLUDE_PATH     /software/boost/${major}.${minor}.${patch}
prepend-path CPLUS_INCLUDE_PATH /software/boost/${major}.${minor}.${patch}

setenv BOOST /software/boost/${major}.${minor}.${patch}
EOF

chown root:root ${boost_modulefile}
chmod 444 ${boost_modulefile}
