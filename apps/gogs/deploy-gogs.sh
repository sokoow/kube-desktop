#!/bin/bash

if [ ! -d $HOME/.kube-volumes/gogs ]; then
 mkdir -p $HOME/.kube-volumes/gogs
fi

# create gogs config dir

if [ ! -d $HOME/.kube-volumes/gogs/gogs/conf ]; then
 mkdir -p $HOME/.kube-volumes/gogs/gogs/conf
fi

# drop config file
cp -fr files/app.ini $HOME/.kube-volumes/gogs/gogs/conf/

sed "s/USER/$USER/g" sed-templates/gogs-deployment.yaml-template > deploy/gogs-deployment.yaml

kubectl apply -f configmap/gogs-sshd-configmap.yaml
kubectl apply -f service/gogs-service.yaml
kubectl apply -f service/gogs-service-sshd.yaml
kubectl apply -f ingress/gogs-ingress.yaml
kubectl apply -f deploy/gogs-deployment.yaml
