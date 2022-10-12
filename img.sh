#!/usr/bin/env bash

NAME='manifoldfinance/capacity'
DATE=$(date +"%d%m%Y-%H%M%S")
docker build . -t manifoldfinance/capacity

if [ $? -ne 0 ]; then
   docker start $NAME
   CONTAINER_ID=$(docker ps -a -f name=$NAME --format "{{.ID}}")
   docker logs -f $CONTAINER_ID
fi
