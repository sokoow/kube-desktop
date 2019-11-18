#!/bin/bash

if [ ! -d $HOME/.kube-volumes/vault ]; then
 mkdir -p $HOME/.kube-volumes/vault
fi

sed "s/USER/$USER/g" sed-templates/deployment.yaml-template > templates/deployment.yaml
helm template . -n vault | kubectl apply -f -
