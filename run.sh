#!/usr/bin/env bash -eu

NO_LOCK_REQUIRED=true

. ./.env
. ./.common.sh


PARAMS=""

displayUsage()
{
  echo "Simulated Mempool with networked containers using Docker."
  echo "You can select the simulation mechanism to use.\n"
  echo "Usage: ${me} [OPTIONS]"
  echo "    -c <ibft2|clique|ethash> : the simulated scenario mechanism that you want to run
                                       on your network, default is ethash"
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
echo "Loading... network"
echo "--------------------"

echo "Starting network..."
docker-compose ${composeFile} build --pull
docker-compose ${composeFile} up --detach

# Print Service Endpoints
./list.sh
