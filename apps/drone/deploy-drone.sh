#!/bin/bash

if [ ! -d $HOME/.kube-volumes/drone ]; then
 mkdir -p $HOME/.kube-volumes/drone
fi

sed "s/USER/$USER/g" sed-templates/drone-deployment.yaml-template > deploy/drone-deployment.yaml

kubectl apply -f service/drone-service.yaml
kubectl apply -f ingress/drone-ingress.yaml
kubectl apply -f deploy/drone-deployment.yaml
kubectl apply -f deploy/drone-agent-deployment.yaml

if [ ! -x /usr/local/bin/drone ]
then
  cd /tmp
  curl -L https://github.com/drone/drone-cli/releases/download/v0.8.6/drone_linux_amd64.tar.gz | tar zx
  sudo install -t /usr/local/bin drone
fi
