#!/usr/bin/env bash

set -e
set -x

cmake_major=3
cmake_minor=10
cmake_patch=0
cmake_version="${cmake_major}.${cmake_minor}.${cmake_patch}"

cmake_dl_url="https://cmake.org/files/v${cmake_major}.${cmake_minor}"
cmake_dl_url="${cmake_dl_url}/cmake-${cmake_version}-Linux-x86_64.tar.gz"

cmake_sha256_url="https://cmake.org/files/v${cmake_major}.${cmake_minor}"
cmake_sha256_url="${cmake_sha256_url}/cmake-${cmake_version}-SHA-256.txt"

cmake_hash_file="$(basename ${cmake_sha256_url})"
cmake_archive="$(basename ${cmake_dl_url})"
cmake_folder="$(basename ${cmake_dl_url} .tar.gz)"

cmake_install_folder=/software/cmake/${cmake_version}
cmake_modulefile=/software/modulefiles/cmake/${cmake_version}

tmp_dir=$(mktemp -d)

function finish {
  rm -rf ${tmp_dir}
}
trap finish EXIT

cd ${tmp_dir}
wget -O ${cmake_archive} ${cmake_dl_url}
wget -O ${cmake_hash_file} ${cmake_sha256_url}

# Confirm archive integrity.
grep ${cmake_archive} ${cmake_hash_file} | /usr/bin/sha256sum --check -

ls -lah

mkdir -p "$(dirname ${cmake_install_folder})" "$(dirname ${cmake_modulefile})"
tar xzf ${cmake_archive}
chown --recursive root:root ${cmake_folder}

# Create compressed archive of the cmake documentation and delete original docs
cd ${cmake_folder}
mv doc/cmake cmake-docs-${cmake_version}
tar -czf cmake-docs-${cmake_version}.tar.gz cmake-docs-${cmake_version}
rm -rf doc cmake-docs-${cmake_version}
cd -

mv ${cmake_folder} ${cmake_install_folder}
chown --recursive root:root ${cmake_install_folder}

# Now, setup the modulefile
cat << EOF > ${cmake_modulefile}
#%Module1.0
##
## cmake/${cmake_version}  modulefile
##
proc ModulesHelp { } {
    puts stderr "cmake/${cmake_version} - sets the environment for cmake"
}

module-whatis   "sets the environment for cmake ${cmake_version}"

prepend-path PATH               ${cmake_install_folder}/bin
prepend-path MANPATH            ${cmake_install_folder}/man

EOF

chown root:root ${cmake_modulefile}
chmod 644 ${cmake_modulefile}
