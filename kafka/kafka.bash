#!/usr/bin/env bash

set -e
set -x

kafka_major=1
kafka_minor=0
kafka_patch=0
kafka_version="${kafka_major}.${kafka_minor}.${kafka_patch}"

scala_major=2
scala_minor=11
scala_version="${scala_major}.${scala_minor}"

kafka_dl_url="http://www.gtlib.gatech.edu/pub/apache/kafka"
kafka_dl_url="${kafka_dl_url}/${kafka_version}"
kafka_dl_url="${kafka_dl_url}/kafka_${scala_version}-${kafka_version}.tgz"

kafka_sha512_url="https://www.apache.org/dist/kafka"
kafka_sha512_url="${kafka_sha512_url}/${kafka_version}"
kafka_sha512_url="${kafka_sha512_url}/kafka_${scala_version}-${kafka_version}.tgz.sha512"

kafka_hash_file="$(basename ${kafka_sha512_url})"
kafka_archive="$(basename ${kafka_dl_url})"
kafka_folder="$(basename ${kafka_dl_url} .tgz)"

kafka_install_folder=/software/kafka/${kafka_version}
kafka_modulefile=/software/modulefiles/kafka/${kafka_version}

tmp_dir=$(mktemp -d)

function finish {
  rm -rf ${tmp_dir}
}
trap finish EXIT

cd ${tmp_dir}
wget -O ${kafka_archive} ${kafka_dl_url}
wget -O ${kafka_hash_file} ${kafka_sha512_url}
ls -lah

printf "You must confirm the following .tgz file hash matches the associated hash file contents!\n"
printf "\n\tThe archive's hash is: %s\n\n" "$(/usr/bin/sha512sum ${kafka_archive})"
printf "\n\tThe expected hash is: %s\n\n" "$(cat ${kafka_hash_file})"

mkdir -p "$(dirname ${kafka_install_folder})" "$(dirname ${kafka_modulefile})"
tar xzf ${kafka_archive}
mv ${kafka_folder} ${kafka_install_folder}
chown --recursive root:root ${kafka_install_folder}


# TODO: Remove this at some point after a bug-fix for the following
# issue is merged into kafka & zookeeper.

# The problem is that zookeeper-server-stop.sh and kafka-server-stop.sh
# may not actually stop the desired processes if the "ps ax" output
# gets truncated. A solution is to add two "w" options to the ps
# arguments. e.g. "ps axww" for full command output so that the PID may
# be reliably gathered.

# See the following issue on GitHub for more info:
#     https://github.com/apache/kafka/pull/1976
sed -i -e "s/ps ax/ps axww/" \
  ${kafka_install_folder}/bin/kafka-server-stop.sh

sed -i -e "s/ps ax/ps axww/" \
  ${kafka_install_folder}/bin/zookeeper-server-stop.sh


# Now, setup the modulefile
cat << EOF > ${kafka_modulefile}
#%Module1.0
##
## kafka/${kafka_major}.${kafka_minor}.${kafka_patch}  modulefile
##
proc ModulesHelp { } {
    puts stderr "kafka/${kafka_version} - sets the environment for kafka"
}

module-whatis   "sets the environment for kafka ${kafka_version}"

module remove java
module add java/1.8.0

prepend-path PATH               ${kafka_install_folder}/bin
prepend-path CLASSPATH          ${kafka_install_folder}/libs
setenv       KAFKA_CONFIG       ${kafka_install_folder}/config

EOF

chown root:root ${kafka_modulefile}
chmod 644 ${kafka_modulefile}
