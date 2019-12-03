#!/bin/bash

cp /home/ubuntu/.ssh/authorized_keys /root/.ssh/authorized_keys
mkdir -p /home/ubuntu/.kube
ln -s /home/ubuntu/.kube /root/.kube
