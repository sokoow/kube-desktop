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

make

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
mkdir -p /etc/docker/certs.d/registry-svc.default.svc.cluster.local:5000
cp ./rootCA.crt /etc/docker/certs.d/registry-svc.default.svc.cluster.local:5000/ca.crt
cp registry-svc.key tls.key
cp registry-svc.crt tls.crt
kubectl create secret generic registry-tls-cert --from-file=./tls.key --from-file=./tls.crt

popd
helm install charts/docker-registry --generate-name

echo "Installing gogs"
helm install charts/gogs --generate-name

echo "Installing drone"
helm install charts/drone --generate-name

echo "Waiting for minio pod to be ready"
while [[ $(kubectl get pods -l app=minio -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') != "True" ]]; do echo "waiting for minio pod" && sleep 1; done

echo "Uploading kubeconfig to minio for CI/CD purposes (kubeconfig_url var in drone later on)"
MINIO_PORT=$(kubectl get svc -l app=minio -o 'jsonpath={..spec.ports..port}')
MINIO_IP=$(kubectl get svc -l app=minio -o 'jsonpath={..spec.clusterIP}')
MINIO_ACCESSKEY=$(kubectl get secret -l app=minio -o 'jsonpath={..data.accesskey}' | base64 -d)
MINIO_SECRETKEY=$(kubectl get secret -l app=minio -o 'jsonpath={..data.secretkey}' | base64 -d)
minio-mc config host add minio "http://$MINIO_IP:$MINIO_PORT" "$MINIO_ACCESSKEY" "$MINIO_SECRETKEY"
minio-mc mb minio/secrets
minio-mc policy set public minio/secrets
minio-mc cp /root/.kube/config minio/secrets/kubeconfig

echo "Installing linkerd2"
curl -sL https://run.linkerd.io/install | sh
cp ~/.linkerd2/bin/linkerd /usr/bin
linkerd install | kubectl apply -f -

echo "Installing telepresence"
curl -s https://packagecloud.io/install/repositories/datawireio/telepresence/script.deb.sh | sudo bash
sudo apt install --no-install-recommends -y telepresence

echo "Applying localhost dns resolver for kube"
/etc/rc.local
systemctl daemon-reload
systemctl restart systemd-resolved
systemctl enable systemd-resolved

echo "Configure git"
git config --global user.email "developer@mykube.awesome"
git config --global user.name "developer"

echo -e "\nDONE! CI stack is deploying, at the moment you see anything at http://git.mykube.awesome/ you should be ready to use some examples. Have Fun!\n"
