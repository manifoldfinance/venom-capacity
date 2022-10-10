#!/usr/bin/env bash
echo "Nukin Docker Env..."
docker-compose down --remove-orphans -v --rmi all
#sudo docker rm --force $(docker ps --all -q)
#sudo docker rmi --force $(docker images --all -q)
docker rm -f -v $(docker ps -aq)

docker rmi -f  $(docker images -q)

docker volume rm $(docker volume ls -q)

docker network rm $(docker network ls -q)

sleep 1
exit 0
