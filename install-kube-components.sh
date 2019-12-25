#!/bin/bash

set -o nounset
set -o errexit

# install traefik
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/v1.7.19/examples/k8s/traefik-rbac.yaml

wget https://raw.githubusercontent.com/containous/traefik/v1.7.19/examples/k8s/traefik-ds.yaml -O /tmp/traefik-ds.yaml
sed -i '/serviceAccountName/a\ \ \ \ \ \ hostNetwork: true' /tmp/traefik-ds.yaml
kubectl apply -f /tmp/traefik-ds.yaml

CURRENT_HOMEDIR=$(pwd)

if [ $CURRENT_HOMEDIR == "/home/vagrant" ]
then
  echo -e "\nRunning inside Vagrant\n"
  cd /vagrant
fi

sudo mkdir -p /data

# delete old helm configs
rm -rf $HOME/.helm

# install helm 3
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
bash get_helm.sh

# install minio client
sudo wget https://dl.min.io/client/mc/release/linux-amd64/mc -O /usr/bin/minio-mc
sudo chmod +x /usr/bin/minio-mc

# Add helm repos
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

# install modified kube-dashboard - non-ssl endpoint enabled for the sake of traefik
kubectl apply -f addons/dashboard.yaml
kubectl delete clusterrolebinding kubernetes-dashboard
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:kubernetes-dashboard

# Deploy small local rook-ceph instance
kubectl apply -f addons/rook-ceph/common.yaml
kubectl apply -f addons/rook-ceph/operator.yaml
kubectl apply -f addons/rook-ceph/toolbox.yaml
kubectl apply -f addons/rook-ceph/sample-cluster.yaml
kubectl apply -f addons/rook-ceph/storageclass.yaml

echo "Installing OpenLDAP"
kubectl apply -f addons/openldap/ldap-nontls-deployment.yaml
kubectl apply -f addons/openldap/ldap-service.yaml

echo "Installing NFS provisioner"
helm install charts/nfs-server-provisioner --generate-name

kubectl create namespace loki
kubectl create namespace linkerd

# deploy ingresses we want
./deploy-ingresses.sh

echo -e "\n ALL DONE! Cluster should be coming up, wait a moment and then you can run deploy-ci-stack.sh. HAVE FUN!\n"
echo -e "\nWORK NOT HARD BUT SMART, HAVE FUN, DON'T DESTROY HISTORY! :D\n"
