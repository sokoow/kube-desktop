#!/bin/bash

POSTGRES_IP=$(kubectl get svc | grep db-postgresql | awk '{ print $3}') || { echo -e '\nPreloading GIT user failed - might be too early to run this script\n' ; exit 1; }
export PGPASSWORD="gogs"

if [ ! -x ./psql_initalized ]
then
  echo "Preloading gitadmin user to Gogs"
  psql -h "${POSTGRES_IP}" -U gogs -d gogs < preload-gogs.sql
  touch .psql_initalized
fi

GIT_SERVER="git.mykube.awesome"
GIT_CREDS="gitadmin:gitadmin"

curl -H "Content-Type: application/json" -X POST -u $GIT_CREDS -d '{ "name": "example-golang-app", "description": "Our first real app", "private": false, "owner": "gitadmin"}' $GIT_SERVER/api/v1/user/repos

curl -H "Content-Type: application/json" -u $GIT_CREDS $GIT_SERVER/api/v1/user/repos

CLONE_URL=$(curl -H "Content-Type: application/json" -s -u gitadmin:gitadmin $GIT_SERVER/api/v1/user/repos | jq .[0].clone_url | tr -d "\"")
#EXTERNAL_CLONE_URL=$(echo $CLONE_URL | sed "s/gogs-svc:3000/$GIT_SERVER/")

if [ -d ./example-golang-app ]
then
  rm -rf ./example-golang-app
fi

#echo
#echo "Clone URL: $CLONE_URL, real clone URL: $EXTERNAL_CLONE_URL"
#echo
git clone $CLONE_URL || { echo -e '\nCloning example repo failed' ; exit 1; }

cd example-golang-app
cp -R ../golang-example/* .
cp -R ../example-deployment .
cp ../Dockerfile .
cp ../.drone.yml .
git add -A
git commit -m "Our first change"

echo -e "\n Killing drone agent pods in case connection got funky\n"
for agent_pod in $(kubectl get po | grep drone-agent | awk '{print $1}'); do kubectl delete pod $agent_pod; done

DRONE_SERVER="drone.mykube.awesome"
DRONE_SERVER_URL="http://$DRONE_SERVER"
DRONE_KUBE="drone-svc.default:8000"

echo
echo "I need a token for Drone, opening up firefox"
echo "Log in as gitadmin/gitadmin and paste the token here:"
echo "Opening $DRONE_SERVER_URL/account/token in new firefox tab"
echo
firefox -new-tab $DRONE_SERVER_URL/account/token
echo -e "\nEnter drone TOKEN from $DRONE_SERVER/account/token:\n"
read token

echo -e "\nDrone TOKEN: $token\n"

echo -e "\nMaking gitadmin user drone admin"

export PGPASSWORD="drone"
psql -h $POSTGRES_IP -U drone -d drone -A -F , -X -t -c "update users set user_admin='t' where user_login='gitadmin'"
psql -h $POSTGRES_IP -U drone -d drone -A -F , -X -t -c "update users set user_active='t' where user_login='gitadmin'"

curl -H "Authorization: Bearer $token" "$DRONE_SERVER_URL/api/user/repos?all=true&flush=true"
curl -H "Authorization: Bearer $token" $DRONE_SERVER_URL/api/repos/gitadmin/example-golang-app -X POST -d '{}'

export PGPASSWORD="gogs"
echo -e "\n Hacking Gogs webhooks to build properly\n"
for hook in $(psql -h $POSTGRES_IP -U gogs -d gogs  -A -F , -X -t -c "select id, url from webhook;"); do
  new_hook=$(echo $hook | sed "s/$DRONE_SERVER/$DRONE_KUBE/")
  record_id=$(echo $new_hook | cut -f1 -d",")
  hook_url=$(echo $new_hook | cut -f2 -d",")
  echo -e "New hook data: $record_id , $hook_url"
  echo -e "\nNew hook: $new_hook\n"
  psql -h $POSTGRES_IP -U gogs -d gogs  -A -F , -X -t -c "update webhook set url='$hook_url' where id=$record_id;"
done

git config --global push.default simple
git push --repo $(echo $CLONE_URL | sed "s/git./${GIT_CREDS}@git./")
