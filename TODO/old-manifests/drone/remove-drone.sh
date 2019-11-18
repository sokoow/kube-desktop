#!/bin/bash

sed "s/USER/$USER/g" sed-templates/drone-deployment.yaml-template > deploy/drone-deployment.yaml

kubectl delete -f service/drone-service.yaml
kubectl delete -f ingress/drone-ingress.yaml
kubectl delete -f deploy/drone-deployment.yaml
kubectl delete -f deploy/drone-agent-deployment.yaml

rm -rf $HOME/.kube-volumes/drone
