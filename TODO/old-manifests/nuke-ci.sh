#!/bin/bash

echo "Removing CI stack"

cd ../apps/gogs
./remove-gogs.sh

cd ../drone
./remove-drone.sh

cd ../minio
./remove-minio.sh

cd ../registry
./remove-registry.sh
