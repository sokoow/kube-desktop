#!/bin/bash

echo "Preloading gitadmin user to Gogs"

if [ ! -x ./psql_initalized ]
then
  POSTGRES_IP=$(kubectl get svc | grep db-postgresql | awk '{ print $3}') || { echo -e '\nPreloading GIT user failed - might be too early to run this script\n' ; exit 1; }
  export PGPASSWORD="gogs"
  psql -h "${POSTGRES_IP}" -U gogs -d gogs < preload-gogs.sql
  touch .psql_initalized
fi

GIT_SERVER="git.mykube.awesome"
GIT_CREDS="gitadmin:gitadmin"

curl -H "Content-Type: application/json" -X POST -u $GIT_CREDS -d '{ "name": "example-golang-app", "description": "Our first real app", "private": false, "owner": "gitadmin"}' $GIT_SERVER/api/v1/user/repos

curl -H "Content-Type: application/json" -u $GIT_CREDS $GIT_SERVER/api/v1/user/repos

CLONE_URL=$(curl -H "Content-Type: application/json" -s -u gitadmin:gitadmin git.mykube.awesome/api/v1/user/repos | jq .[0].clone_url | tr -d "\"")
EXTERNAL_CLONE_URL=$(echo $CLONE_URL | sed "s/gogs-svc:3000/$GIT_SERVER/")

if [ -d ./example-golang-app ]
then
  rm -rf ./example-golang-app
fi

echo
echo "Clone URL: $CLONE_URL, real clone URL: $EXTERNAL_CLONE_URL"
echo
git clone $EXTERNAL_CLONE_URL || { echo -e '\nCloning example repo failed' ; exit 1; }

cd example-golang-app
cp -R ../golang-example .
cp -R ../example-deployment .
cp ../Dockerfile .
cp ../.drone.yml .
git add -A
git commit -m "Our first change"

echo -e "\n Killing drone agent pods in case connection got funky\n"
for agent_pod in $(kubectl get po | grep drone-agent | awk '{print $1}'); do kubectl delete pod $agent_pod; done

DRONE_SERVER="http://drone.mykube.awesome"
echo
echo "I need a token for Drone, opening up firefox"
echo "Log in as gitadmin/gitadmin and paste the token here:"
echo "Opening $DRONE_SERVER/account/token in new firefox tab"
echo
firefox -new-tab $DRONE_SERVER/account/token
echo -e "\nEnter drone TOKEN from $DRONE_SERVER/account/token:\n"
read token

echo -e "\nDrone TOKEN: $token\n"

curl -H "Authorization: Bearer $token" "http://drone.mykube.awesome/api/user/repos?all=true&flush=true"
curl -H "Authorization: Bearer $token" drone.mykube.awesome/api/repos/gitadmin/example-golang-app -X POST -d '{}'
git config --global push.default simple
git push --repo $(echo $EXTERNAL_CLONE_URL | sed "s/git./${GIT_CREDS}@git./")
