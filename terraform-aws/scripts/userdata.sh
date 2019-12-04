#!/bin/bash

cp /home/ubuntu/.ssh/authorized_keys /root/.ssh/authorized_keys
mkdir -p /home/ubuntu/.kube
ln -s /home/ubuntu/.kube /root/.kube

sudo systemctl mask unattended-upgrades.service
sudo systemctl stop unattended-upgrades.service

while systemctl is-active --quiet unattended-upgrades.service; do sleep 1; done
