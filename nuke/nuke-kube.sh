#!/bin/bash

echo "Removing whole kube"

sudo kubeadm reset

echo "Removing CI stack data and database storage"

sudo rm -rf /home/$USER/.kube-volumes/postgres
sudo rm -rf /home/$USER/.kube-volumes/minio
sudo rm -rf /home/$USER/.kube-volumes/gogs
sudo rm -rf /home/$USER/.kube-volumes/drone
sudo rm -rf /home/$USER/.kube-volumes/registry
