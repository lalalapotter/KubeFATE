#!/bin/bash

DIR=$(dirname $0)
source ${DIR}/const.sh

main()
{
    # federatedai/kubefate should build from source code
    docker pull ${DOCKER_REGISTRY}/federatedai/kubefate:${KUBEFATE_VERSION}
    kind load docker-image ${DOCKER_REGISTRY}/federatedai/kubefate:${KUBEFATE_VERSION}

    docker pull ${DOCKER_REGISTRY}/mariadb:10
    kind load docker-image ${DOCKER_REGISTRY}/mariadb:10

    docker pull ${DOCKER_REGISTRY}/mysql:8
    kind load docker-image ${DOCKER_REGISTRY}/mysql:8

    docker pull ${DOCKER_REGISTRY}/fluent/fluentd:v1.11-debian-1
    kind load docker-image ${DOCKER_REGISTRY}/fluent/fluentd:v1.11-debian-1

    for image in "fateboard" "python" "eggroll" "client"
    do
      docker pull ${DOCKER_REGISTRY}/federatedai/${image}:${FATE_VERSION}
      kind load docker-image ${DOCKER_REGISTRY}/federatedai/${image}:${FATE_VERSION}
      if [ $? -ne 0 ]; then
        echo "Fatal: load fate image ${image} failed"
        exit 1
      else
        exit 0
      fi
    done
}

main
