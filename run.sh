#!/usr/bin/env bash
set -eu

NO_LOCK_REQUIRED=true

. ./.env
. ./.common.sh


NAME='manifoldfinance/capacity'
PARAMS=""
DATE=$(date +"%d%m%Y-%H%M%S")
CONTAINER_ID=$(docker ps -a -f name=$NAME --format "{{.ID}}")

displayUsage()
{
  echo "Simulated Mempool with networked containers using Docker."
  echo "You can select the simulation mechanism to use.\n"
  echo "Usage: ${me} [OPTIONS]"
  echo "    -c <c1|c2|c3> : the simulated scenario mechanism that you want to run
                                       on your network, default is c1"
  echo "    -e                       : setup env."
  echo "    -s                       : simulated scenario algorithm. Note the -s option must be preceeded by the -c option"
  exit 0
}
composeFile="docker-compose"


composeFile="-f ${composeFile}.yml"

# Ensure PID Lock and Mutex
echo "${composeFile}" > ${LOCK_FILE}
echo "${SAMPLE_VERSION}" >> ${LOCK_FILE}

echo "${bold}*************************************"
echo "Simulation Mempool Overlay - ${SAMPLE_VERSION}"
echo "*************************************${normal}"
echo "Loading.... containers"
echo "--------------------"

echo "Building Network Services..."

docker build . -t manifoldfinance/capacity --no-cache
sleep 1

docker-compose ${composeFile} build --pull
sleep 1
echo "Starting  simulation...."
ORIGIN_WORKTIME=2s CLIENT_ORIGIN=http://proxy:7000 PROXY_ADAPTIVE=true docker-compose ${composeFile} up --detach

echo "Service Endpoints....."
# Print Service Endpoints
./list.sh
sleep 1
