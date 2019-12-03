#!/usr/bin/env bash
set -x
set -eu
set -o pipefail

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${CURRENT_DIR}/../ansible

ansible --version
ansible-playbook -i ../ansible/inventory playbooks/main.yml
