#!/bin/bash

echo "Preloading gitadmin user to Gogs"

POSTGRES_IP=$(kubectl get svc | grep db-postgresql | awk '{ print $3}')
export PGPASSWORD="gogs"
psql -h "${POSTGRES_IP}" -U gogs -d gogs < preload-gogs.sql


GIT_SERVER="http://git.mykube.awesome"
GIT_CREDS="gitadmin:gitadmin"

curl -H "Content-Type: application/json" -X POST -u $GIT_CREDS -d '{ "name": "example-golang-app", "description": "Our first real app", "private": false, "owner": "gitadmin"}' $GIT_SERVER/api/v1/user/repos

curl -H "Content-Type: application/json" -u $GIT_CREDS $GIT_SERVER/api/v1/user/repos

CLONE_URL=$(curl -H "Content-Type: application/json" -s -u gitadmin:gitadmin git.mykube.awesome/api/v1/user/repos | jq .[0].clone_url)

if [ -d ./example-golang-app ]
then
  rm -rf ./example-golang-app
fi

git clone $CLONE_URL

cd example-golang-app
cp -R ../golang-example .
cp -R ../example-deployment .
cp ../.drone.yml .
cp ../Dockerfile .
git add -A
git commit -m "Our first change"

DRONE_SERVER="http://drone.mykube.awesome"

echo "I need a token for Drone, opening up firefox"
echo "Log in as gitadmin/gitadmin and paste the token here:"

read token
firefox -new-tab $DRONE_SERVER/account/token

echo $token

curl -H "Authorization: Bearer $token" "http://drone.mykube.awesome/api/user/repos?all=true&flush=true"
curl -H "Authorization: Bearer $token" drone.mykube.awesome/api/repos/gitadmin/example-golang-app -X POST -d '{}'

git push --repo $(echo $CLONE_URL | sed 's/drone./"${GIT_CREDS}"@drone./')
