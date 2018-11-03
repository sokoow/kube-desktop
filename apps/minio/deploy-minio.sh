#!/bin/bash

if [ ! -d $HOME/.kube-volumes/minio ]; then
 mkdir -p $HOME/.kube-volumes/minio
fi

sed "s/USER/$USER/g" sed-templates/deployment.yaml-template > templates/deployment.yaml
helm template . -n minio | kubectl apply -f -
