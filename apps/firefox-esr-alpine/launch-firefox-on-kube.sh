#!/bin/bash

USER=$(whoami)
MY_GID=$(grep ^$(whoami) /etc/group | cut -d":" -f3)
MY_UID=$(grep ^$(whoami) /etc/passwd | cut -d":" -f3)

if [ ! -d $HOME/.kube-volumes/firefox ]; then
 mkdir -p $HOME/.kube-volumes/firefox
fi

# hack to make .Xauthority to be read correctly by firefox
sed  "s/MY_GID/$MY_GID/g" Dockerfile-template > Dockerfile
sed -i "s/MY_UID/$MY_UID/g" Dockerfile
sed "s/XDISP/$DISPLAY/g" deploy/deploy-firefox.yaml-template > deploy/deploy-firefox.yaml
sed -i "s/USER/$USER/g" deploy/deploy-firefox.yaml

sudo docker build -t firefox:kube-edition .
kubectl apply -f deploy/deploy-firefox.yaml
