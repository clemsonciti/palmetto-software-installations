#!/usr/bin/env bash

if [[ ! -v PBS_JOBID ]]; then
    printf "ERROR: This script should be run within a PBS job!\n"
    exit 1
fi

major=1
minor=0
patch=0

module add kafka/${major}.${minor}.${patch}

# Sets where zookeeper and kafka will emit application logs
export LOG_DIR=/local_scratch/${USER}/kafka-test-${PBS_JOBID}
mkdir -p ${LOG_DIR}

tmp_dirs="${LOG_DIR}"
function finish {
  ls -lah ${tmp_dirs}
  #rm -rf ${tmp_dirs}
}
trap finish EXIT

set -x

# Generate custom zookeeper properties file that utilizes /local_scratch
sed -e "s+/tmp/zookeeper+${LOG_DIR}+" ${KAFKA_CONFIG}/zookeeper.properties > ${LOG_DIR}/zookeeper.properties

cat ${LOG_DIR}/zookeeper.properties

# Uses /tmp/zookeeper for storing data
zookeeper-server-start.sh -daemon ${LOG_DIR}/zookeeper.properties

sleep 10

# Uses /tmp/kafka-logs for storing data
kafka-server-start.sh \
    -daemon \
    ${KAFKA_CONFIG}/server.properties \
    --override log.dirs="${LOG_DIR}/data"

sleep 10

kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test

kafka-topics.sh --list --zookeeper localhost:2181

printf "This is a message.\nThis is another message.\n" | kafka-console-producer.sh --broker-list localhost:9092 --topic test

kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning --timeout-ms 1000

kafka-server-stop.sh 

zookeeper-server-stop.sh

sleep 10

printf "Spot check for any straggling java processes (ignore jps).\n"
jps