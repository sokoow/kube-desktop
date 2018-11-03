#!/bin/bash

if [ ! -d $HOME/.kube-volumes/postgres ]; then
 mkdir -p $HOME/.kube-volumes/postgres
fi

sudo chown -R 1001:1001 ~/.kube-volumes/postgres/

sed  "s/MY_GID/$MY_GID/g" values-template.yaml > values.yaml
sed -i "s/MY_UID/$MY_UID/g" values.yaml

sed "s/USER/$USER/g" sed-templates/statefulset.yaml-template > templates/statefulset.yaml
helm template . -n db | kubectl apply -f -
