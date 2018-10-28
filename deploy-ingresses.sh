#!/bin/bash

for manifest in $(find ./ingress -iname *.yaml); do
  INGRESS_HOST=$(cat $manifest | grep host | cut -d":" -f2 | tr -d "[:space:]")
  if ! grep -q "$INGRESS_HOST" /etc/hosts; then
    echo "Adding ingress host $INGRESS_HOST to /etc/hosts"
    kubectl apply -f $manifest
    sudo sh -c "echo '127.0.0.1 $INGRESS_HOST' >> /etc/hosts"
  fi
done
