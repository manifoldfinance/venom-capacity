#!/usr/bin/env bash
export DOCKER_BUILDKIT=1
docker-compose build
export $(egrep -v '^#' .env | xargs)
ORIGIN_WORKTIME=2s CLIENT_ORIGIN=http://proxy:7000 PROXY_ADAPTIVE=true docker-compose up
sleep 1
