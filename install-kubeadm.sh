#!/bin/bash

DISTRO_CODENAME=$(cat /etc/lsb-release | grep DISTRIB_CODENAME | cut -f2 -d"=")

# hack for Mint 18
if [ $DISTRO_CODENAME == "sonya" ]
then
  DISTRO_CODENAME="xenial"
fi

# add kube repo
if [ ! -f /etc/apt/sources.list.d/kubernetes.list ]
then
  sudo apt-get update && apt-get install -y apt-transport-https curl jq
  sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
  sudo echo "deb https://apt.kubernetes.io/ kubernetes-$DISTRO_CODENAME main" > /etc/apt/sources.list.d/kubernetes.list
  sudo apt-get update
  sudo apt-get install -y kubelet kubeadm kubectl
fi

# not needed yet
# apt-mark hold kubelet kubeadm kubectl

echo "
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
failSwapOn: false
clusterDomain: cluster.local
---
kind: ClusterConfiguration
apiVersion: kubeadm.k8s.io/v1alpha3
networking:
  podSubnet: 10.244.0.0/16
  dnsDomain: cluster.local
  serviceSubnet: 10.96.0.0/12
" > /tmp/config.yaml

sudo kubeadm init --config /tmp/config.yaml --ignore-preflight-errors=Swap

# delete old kube configs
rm -rf $HOME/.kube

# copy new kube configs to home dir
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


sudo sysctl net.bridge.bridge-nf-call-iptables=1

# let's fire up canal overlay network
kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/canal/rbac.yaml
kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/canal/canal.yaml

# so let's use weave overlay, that always works
# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

# deploy kuberouter overlay
# kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter-all-features.yaml

# allows to run containers on the only node we have - master
kubectl taint nodes --all node-role.kubernetes.io/master-

# install heapster
kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/standalone/heapster-controller.yaml

# install traefik
kubectl apply -f https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-rbac.yaml

wget https://raw.githubusercontent.com/containous/traefik/master/examples/k8s/traefik-ds.yaml -O /tmp/traefik-ds.yaml
sed -i '/serviceAccountName/a\ \ \ \ \ \ hostNetwork: true' /tmp/traefik-ds.yaml
kubectl apply -f /tmp/traefik-ds.yaml

# patch traefik service to listen on nodeport 30000
kubectl apply -f service/traefik-svc.yaml

# delete old helm configs
rm -rf $HOME/.helm

# install helm
sudo curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash

# install tiller for helm
kubectl -n kube-system create sa tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller

# install modified kube-dashboard - non-ssl endpoint enabled for the sake of traefik
kubectl apply -f deploy/kubernetes-dashboard.yaml

# allow the dashboard user to have access to everything - non recommended for prod, but here we own the cluster
kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

# deploy ingresses we want
./deploy-ingresses.sh

mkdir -p ~/.kube-volumes

echo -e "\n ALL DONE! Cluster should be coming up, wait a moment and then you can run deploy-ci-stack.sh. HAVE FUN!\n"
echo -e "\nWORK NOT HARD BUT SMART, HAVE FUN, DON'T DESTROY HISTORY! :D\n"
