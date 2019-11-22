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

# openssl genrsa -out rootCA.key 4096
# openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.crt -extfile openssl2.conf -extensions req_ext
# openssl req -new -sha256 \
#     -key tls.key \
#     -subj "/C=US/ST=CA/O=MyOrg, Inc./CN=registry-svc" \
#     -reqexts SAN \
#     -config <(cat /etc/ssl/openssl.cnf \
#         <(printf "\n[SAN]\nsubjectAltName=DNS:registry-svc,DNS:registry.mykube.awesome")) \
#     -out tls.csr
# openssl x509 -req -in tls.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out tls.crt -days 500 -sha256 -extfile openssl2.conf -extensions req_ext
#
# openssl req -newkey rsa:4096 -nodes -sha256 -keyout ca.key -x509 -days 365 -config openssl.conf -out ca.crt -new -subj /C=EU
# openssl req -newkey rsa:4096 -nodes -sha256 -CA ca.crt -CAkey ca.key -keyout tls.key -out tls.csr -config openssl.conf -new -subj /C=EU
# openssl x509 -req -days 365 -in tls.csr -CA ca.crt -extfile openssl.conf -CAkey ca.key -CAcreateserial -out tls.crt
#
# openssl req -newkey rsa:4096 -nodes -sha256 -keyout tls.key -x509 -days 365 -out tls.crt -config openssl.conf -new -subj /C=EU

mkdir -p /etc/docker/certs.d/registry-svc:5000
cp ./rootCA.crt /etc/docker/certs.d/registry-svc:5000/ca.crt
cp registry-svc.key tls.key
cp registry-svc.crt tls.crt
kubectl create secret generic registry-tls-cert --from-file=./tls.key --from-file=./tls.crt

popd
helm install charts/docker-registry --generate-name

echo "Installing gogs"
helm install charts/gogs --generate-name

echo "Installing drone"
helm install charts/drone --generate-name

echo -e "\nDONE! CI stack is deploying, at the moment you see anything at http://git.mykube.awesome/ you should be ready to use some examples. Have Fun!\n"
