#!/bin/bash

echo "Removing posgres and postgres data"

cd ../apps/postgresql/
./remove-postgres.sh
