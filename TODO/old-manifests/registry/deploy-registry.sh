#!/bin/bash

if [ ! -d $HOME/.kube-volumes/registry ]; then
 mkdir -p $HOME/.kube-volumes/registry
fi

if [ ! -d $HOME/.kube-volumes/registry/certs ]; then
 mkdir -p $HOME/.kube-volumes/registry/certs
fi


cd files
openssl req -newkey rsa:4096 -nodes -sha256 -keyout domain.key -x509 -days 365 -out domain.crt -config openssl.conf -new -subj /C=EU
cp domain.key domain.crt $HOME/.kube-volumes/registry/certs
cd ..

sed "s/USER/$USER/g" sed-templates/registry-deployment.yaml-template > deploy/registry-deployment.yaml

kubectl apply -f configmap/registry-configmap.yaml
kubectl apply -f service/registry-service.yaml
kubectl apply -f ingress/registry-ingress.yaml
kubectl apply -f deploy/registry-deployment.yaml
