#!/bin/bash

set -o nounset
set -o errexit

curl -sLS https://get.k3sup.dev | sh
sudo install k3sup /usr/local/bin/

sudo k3sup install --local --k3s-extra-args '--no-deploy=servicelb --no-deploy=traefik'
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config

./install-kube-components.sh
./deploy-ingresses.sh

echo -e "\n ALL DONE! Cluster should be coming up, wait a moment and then you can run deploy-ci-stack.sh. HAVE FUN!\n"
echo -e "\nWORK NOT HARD BUT SMART, HAVE FUN, DON'T DESTROY HISTORY! :D\n"
