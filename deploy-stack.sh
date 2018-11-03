#!/bin/bash

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
