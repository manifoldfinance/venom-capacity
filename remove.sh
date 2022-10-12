#!/usr/bin/env bash -u
NO_LOCK_REQUIRED=false

. ./.env
. ./.common.sh

nukeContainer(){
  if [[ ! -z `docker ps -a | grep $1` ]]; then
    docker image rm $1
  fi
}

echo "${bold}*************************************"
echo "Simulation Mempool for Capacity at ${version}"
echo "*************************************${normal}"
echo "🔴 HALTING......."
docker-compose ${composeFile} down -v
sleep 1
echo "Cleaning up ......."
docker-compose ${composeFile} rm -sfv

# our image
if [[ ! -z `docker ps -a | grep manifoldfinance/capacity` ]]; then
  nukeContainer manifoldfinance/capacity
fi


rm ${LOCK_FILE}
echo "🔴 Network Mutex file ${LOCK_FILE} removed"