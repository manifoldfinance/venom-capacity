#!/usr/bin/env bash
docker --version || exit
go mod download
docker build . -t manifoldfinance/capacity
export $(egrep -v '^#' .env | xargs)
ORIGIN_WORKTIME=2s CLIENT_ORIGIN=http://proxy:7000 PROXY_ADAPTIVE=true docker-compose up
sleep 1
exit 0

