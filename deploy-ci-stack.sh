#!/bin/bash

CURRENT_HOMEDIR=$(pwd)

if [ $CURRENT_HOMEDIR == "/home/vagrant" ]
then
  echo -e "\nRunning inside Vagrant\n"
  cd /vagrant
fi

cd apps/postgresql
./deploy-postgres.sh

cd ../minio
./deploy-minio.sh

cd ../registry
./deploy-registry.sh

cd ../gogs
./deploy-gogs.sh

cd ../drone
./deploy-drone.sh

echo -e "\nDONE! CI stack is deploying, at the moment you see anything at http://git.mykube.awesome/ you should be ready to use some examples. Have Fun!\n"
