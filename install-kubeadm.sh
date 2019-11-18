#!/bin/bash

set -o nounset
set -o errexit

DISTRO_CODENAME=$(cat /etc/lsb-release | grep DISTRIB_CODENAME | cut -f2 -d"=")

# hack for Mint 18
if [ $DISTRO_CODENAME == "sonya" ]
then
  DISTRO_CODENAME="xenial"
fi

# add kube repo
if [ ! -f /etc/apt/sources.list.d/kubernetes.list ]
then
  sudo apt-get update && sudo apt-get install -y apt-transport-https curl jq
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
  sudo apt-get update
  sudo apt-get install -y kubelet kubeadm kubectl
fi

# not needed yet
# apt-mark hold kubelet kubeadm kubectl


# more docs on this here: https://godoc.org/k8s.io/kubernetes/cmd/kubeadm/app/apis/kubeadm/v1alpha3
cp kubeadm-config.yaml /tmp/config.yaml

sudo kubeadm init --config /tmp/config.yaml --ignore-preflight-errors=Swap --ignore-preflight-errors=SystemVerification

# delete old kube configs
rm -rf $HOME/.kube

# copy new kube configs to home dir
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


sudo sysctl net.bridge.bridge-nf-call-iptables=1

# let's fire up canal overlay network
kubectl apply -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml

# so let's use weave overlay, that always works
# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# deploy kuberouter overlay
# kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml

# allows to run containers on the only node we have - master
kubectl taint nodes --all node-role.kubernetes.io/master-

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


kubectl apply -f service/traefik-svc.yaml

# delete old helm configs
rm -rf $HOME/.helm

# install helm 3
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh
bash get_helm.sh

# Add helm repos
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
helm repo add stable https://kubernetes-charts.storage.googleapis.com/


## install helm
#sudo curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash

# install tiller for helm
#kubectl -n kube-system create sa tiller
#kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
#helm init --service-account tiller

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


# deploy ingresses we want
./deploy-ingresses.sh

mkdir -p ~/.kube-volumes

echo -e "\n ALL DONE! Cluster should be coming up, wait a moment and then you can run deploy-ci-stack.sh. HAVE FUN!\n"
echo -e "\nWORK NOT HARD BUT SMART, HAVE FUN, DON'T DESTROY HISTORY! :D\n"
