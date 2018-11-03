#!/bin/bash

sed "s/USER/$USER/g" sed-templates/registry-deployment.yaml-template > deploy/registry-deployment.yaml

kubectl delete -f configmap/registry-configmap.yaml
kubectl delete -f service/registry-service.yaml
kubectl delete -f ingress/registry-ingress.yaml
kubectl delete -f deploy/registry-deployment.yaml

rm -rf $HOME/.kube-volumes/registry
