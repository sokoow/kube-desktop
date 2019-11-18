#!/bin/bash

echo "Removing whole kube"

sudo kubeadm reset

echo "Removing CI stack data and database storage"

rm ../examples/.psql_initalized
