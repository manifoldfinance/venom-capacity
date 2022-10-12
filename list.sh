#!/usr/bin/env bash
set -eu
# shellcheck source=.env
NO_LOCK_REQUIRED=false
# shellcheck source=.env
. ./.env
# shellcheck source=.common.sh
. ./.common.sh

HOST=${DOCKER_PORT_2375_TCP_ADDR:-"localhost"}

# Displays links to exposed services
echo "${bold}*************************************"
echo "Version       ${SAMPLE_VERSION}"
echo "*************************************${normal}"
echo "Network.... containers .... OK"
sleep 1
echo "--------------------"
echo "List endpoints and services"
echo "----------------------------------"

# Displays services list with port mapping
docker-compose ps
dots=""
maxRetryCount=50

# Determine if ELK is setup
#venom_setup=true
#if [ -z $(docker-compose -f docker-compose_venom.yml ps -q fuzzer) ] || [ -z $(docker ps -q --no-trunc | grep $(docker-compose -f docker-compose_venom.yml ps -q fuzzer)) ] ||
#    [ -z $(docker-compose -f docker-compose_venom_poa.yml ps -q fuzzer) ] || [ -z $(docker ps -q --no-trunc | grep $(docker-compose -f docker-compose_venom_fuzz.yml ps -q fuzzer)) ]; then
#  venom_setup=false
#fi

#if [ $venom_setup == true ]; then
#    while [ "$(curl -m 10 -s -o /dev/null -w ''%{http_code}'' http://${HOST}:5601/api/status)" != "200" ] && [ ${#dots} -le ${maxRetryCount} ]
#    do
#      dots=$dots"."
#      printf "VENOM is starting, please wait $dots\\r"
#      sleep 10
#    done


echo "****************************************************************"
  echo "[OFF]: RPC HTTP service endpoint       : http://${HOST}:8545"
  echo "[ON]: Proxy address                    : http://${HOST}:7000/"
  echo "[ON]: Prometheus address               : http://${HOST}:9090/graph"
  echo "[ON]: Grafana address                  : http://${HOST}:3000/d/__zqZa-Zz/rpc-capacity-manager?orgId=1&refresh=5s"
  if [ $IS_TEST == true ]; then
    echo "DEBUG output logs address            : http://${HOST}:8080/metrics"
  fi
  echo "****************************************************************"
  
  sleep 1
