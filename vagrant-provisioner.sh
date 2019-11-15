#!/bin/bash

set -o nounset
set -o errexit

cd /vagrant
git clone https://github.com/sokoow/kube-desktop
cd kube-desktop
./install-kubeadm.sh
./deploy-ci-stack.sh
