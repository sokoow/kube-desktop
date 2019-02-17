#!/bin/bash

CURRENT_HOMEDIR=$(pwd)

if [ $CURRENT_HOMEDIR == "/home/vagrant" ]
then
  echo -e "\nRunning inside Vagrant\n"
  cd /vagrant
fi

# deploy ingress manifests
for manifest in $(find ./ -iname *-ingress.yaml); do
  echo "Adding ingress manifest $INGRESS_HOST to kube"
  kubectl apply -f $manifest
done

if ! grep -q "kubeapi.mykube.awesome" /etc/hosts; then
    echo "Adding kubeapi host entry"
    sudo sh -c "echo '127.0.0.1 kubeapi.mykube.awesome' >> /etc/hosts"
fi

# add missing entries to hosts file
for ingress_url in $(kubectl get ingress --all-namespaces | tail -n +2 | awk '{print $3}'); do
  if ! grep -q "$ingress_url" /etc/hosts; then
    echo "Adding ingress host $ingress_url to /etc/hosts"

    sudo sh -c "echo '127.0.0.1 $ingress_url' >> /etc/hosts"
  fi
done
