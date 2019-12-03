#!/bin/bash

set -x
set -o pipefail

apt-get update
UCF_FORCE_CONFFNEW=1 DEBIAN_FRONTEND=noninteractive apt-get install -y -o Dpkg::Options::=--force-confnew mc git curl wget sudo make python

echo "Opening curl"
wget https://get.docker.com -qO /tmp/get-docker.sh
chmod +x /tmp/get-docker.sh
/tmp/get-docker.sh
