#!/bin/bash

sed  "s/MY_GID/$MY_GID/g" values-template.yaml > values.yaml
sed -i "s/MY_UID/$MY_UID/g" values.yaml

sed "s/USER/$USER/g" sed-templates/statefulset.yaml-template > templates/statefulset.yaml

helm template . -n db | kubectl delete -f -
sudo rm -rf $HOME/.kube-volumes/postgres
