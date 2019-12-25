#!/bin/bash

set -o nounset
set -o errexit

echo "Checking if we're running in vagrant"

CURRENT_USER=$(whoami)

if [ $CURRENT_USER == "vagrant" ]
then
  echo -e "\nRunning inside Vagrant\n"
  cd /vagrant
else
  cd /home
fi

echo "Cloning kube-desktop git repository"
git clone https://github.com/sokoow/kube-desktop
cd kube-desktop
./install-k3sup.sh
./deploy-ci-stack.sh
