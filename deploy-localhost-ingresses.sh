#!/bin/bash

# deploy ingress manifests
for manifest in $(find ./ -iname *-ingress.yaml); do
  INGRESS_HOST=$(grep host: $manifest  | awk '{print $3}' | tr -d " ")
  if grep -Fxq "127.0.0.1 $INGRESS_HOST" /etc/hosts
  then
      echo -e "Host alias $INGRESS_HOST already found\n"
  else
    echo "Adding ingress manifest $INGRESS_HOST to /etc/hosts"
    echo "127.0.0.1 $INGRESS_HOST" | sudo tee --append /etc/hosts
  fi

done
