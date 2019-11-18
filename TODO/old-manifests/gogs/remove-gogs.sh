#!/bin/bash

sed "s/USER/$USER/g" sed-templates/gogs-deployment.yaml-template > deploy/gogs-deployment.yaml

kubectl delete -f configmap/gogs-sshd-configmap.yaml
kubectl delete -f service/gogs-service.yaml
kubectl delete -f service/gogs-service-sshd.yaml
kubectl delete -f ingress/gogs-ingress.yaml
kubectl delete -f deploy/gogs-deployment.yaml

rm -rf $HOME/.kube-volumes/gogs
