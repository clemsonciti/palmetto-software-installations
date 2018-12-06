#!/usr/bin/env bash

cd $(dirname $0)

set -x
set -e

whoami
rm -f rclone-current-linux-amd64.zip
wget https://downloads.rclone.org/rclone-current-linux-amd64.zip
unzip rclone-current-linux-amd64.zip
ls -lah rclone-v*.*-linux-amd64
