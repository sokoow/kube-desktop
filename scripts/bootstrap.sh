#!/bin/bash

set -x
set -o pipefail

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y mc git curl wget

echo "Opening curl"
wget https://get.docker.com -qO /tmp/get-docker.sh
chmod +x /tmp/get-docker.sh
/tmp/get-docker.sh
