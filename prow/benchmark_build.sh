#!/usr/bin/env bash

# building prometheus
make build

#pushing docker image
docker login -u _json_key --password-stdin https://gcr.io < /etc/serviceaccount/service-account.json
docker build --pull=true --rm=true -t $PROW_BENCHMARK_DOCKER_IMAGE ./
docker push $PROW_BENCHMARK_DOCKER_IMAGE

#cleaning node docker
docker rmi $PROW_BENCHMARK_DOCKER_IMAGE
 
echo -e "\n\n >> The docker image for the PR has been pushed to https://$PROW_BENCHMARK_DOCKER_IMAGE"