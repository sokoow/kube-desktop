#!/bin/bash

# if for whatever reason your docker images went down
# and kube is not accessible anymore

sudo systemctl restart kubelet
