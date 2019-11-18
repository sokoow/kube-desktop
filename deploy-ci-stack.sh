#!/bin/bash

CURRENT_HOMEDIR=$(pwd)

if [ $CURRENT_HOMEDIR == "/home/vagrant" ]
then
  echo -e "\nRunning inside Vagrant\n"
  cd /vagrant
fi

echo "Installing postgresql"
helm install charts/postgresql --generate-name

echo "Installing minio"
helm install charts/minio --generate-name

echo "Installing docker-registry"
pushd .
cd charts/docker-registry/files

openssl req -newkey rsa:4096 -nodes -sha256 -keyout tls.key -x509 -days 365 -out tls.crt -config openssl.conf -new -subj /C=EU
kubectl create secret generic registry-tls-cert --from-file=./tls.key --from-file=./tls.crt
popd
helm install charts/docker-registry --generate-name

# cd ../gogs
# ./deploy-gogs.sh
#
# cd ../drone
# ./deploy-drone.sh

echo -e "\nDONE! CI stack is deploying, at the moment you see anything at http://git.mykube.awesome/ you should be ready to use some examples. Have Fun!\n"
