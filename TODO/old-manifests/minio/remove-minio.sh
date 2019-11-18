#!/bin/bash

sed "s/USER/$USER/g" sed-templates/deployment.yaml-template > templates/deployment.yaml
helm template . -n minio | kubectl delete -f -

sudo rm -rf $HOME/.kube-volumes/minio
