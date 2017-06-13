#!/bin/bash

# Creates Kubernetes Config Maps to hold the various configuration parameters for the jobs

HOST=${1:-localhost}
VHOST=${2:-/}
USERNAME=${3:-guest}
PASSWORD=${4:-guest}
# when overriding the default, enclose the URL with single quotes to escape the ampersand from shell
MONGODB_URL=${5:-mongodb://localhost:27017/bare-metal?journal=false&w=1&appName=amqp-mongodb-bare-metal}
EXPECTED_MESSAGE_COUNT=${6:-1048576}
PREFETCH_COUNT=${7:-128}
CONCURRENCY=${8:-32}
MODVALUE=${9:-10000}

CONFIGURATION=amqp-mongodb-bare-metal-producer-configuration

CREATE="kubectl create configmap ${CONFIGURATION} \
            --from-literal host=${HOST} \
            --from-literal virtual-host=${VHOST} \
            --from-literal username=${USERNAME} \
            --from-literal password=${PASSWORD} \
            --from-literal prefetch-count=${PREFETCH_COUNT} \
            --from-literal concurrency=${CONCURRENCY} \
            --from-literal mongodb-url=${MONGODB_URL} \
            --from-literal modvalue=${MODVALUE} \
            --from-literal expected-message-count=${EXPECTED_MESSAGE_COUNT}"

echo ${CREATE}
${CREATE}

GET="kubectl get configmaps ${CONFIGURATION} -o yaml"
echo ${GET}
${GET}
