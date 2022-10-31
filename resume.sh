#!/usr/bin/env bash -u
NO_LOCK_REQUIRED=false


. ./.env
. ./.common.sh


echo "${bold}*************************************"
echo "Simulation Mempool for Capacity at ${version}"
echo "*************************************${normal}"
echo ""
echo "🔵 Resuming network..."
echo "----------------------------------"

docker-compose ${composeFile} start