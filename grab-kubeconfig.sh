#!/bin/bash

SSH_PORT=$(vagrant ssh-config | grep -i port | awk '{print $2}')
SSH_KEY=$(vagrant ssh-config | grep IdentityFile | awk '{print $2}')
USER=$(whoami)

ssh-keygen -f "/home/$USER/.ssh/known_hosts" -R [127.0.0.1]:$SSH_PORT

scp -P $SSH_PORT -i $SSH_KEY vagrant@127.0.0.1:/home/vagrant/.kube/config ~/.kube/config
sed -i 's/server:.*/server: https:\/\/127.0.0.1:6443/' ~/.kube/config
