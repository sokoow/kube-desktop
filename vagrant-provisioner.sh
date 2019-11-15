#!/bin/bash

set -o nounset
set -o errexit

cd /vagrant
echo "Cloning kube-desktop git repository"
git clone https://github.com/sokoow/kube-desktop
cd kube-desktop
./install-kubeadm.sh
./deploy-ci-stack.sh
