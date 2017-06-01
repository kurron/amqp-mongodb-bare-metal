#!/bin/bash

HOST=${1:-localhost}
VHOST=${2:-/}
USERNAME=${3:-guest}
PASSWORD=${4:-guest}
MOD_COUNT=${5:-100}
PREFETCH_COUNT=${6:-1}
CONCURRENCY=${7:-1}

CMD="docker run \
            --cpus 1 \
            --env consumer_modvalue=1000 \
            --env spring_rabbitmq_host=${HOST} \
            --env spring_rabbitmq_virtual-host=${VHOST} \
            --env spring_rabbitmq_username=${USERNAME} \
            --env spring_rabbitmq_password=${PASSWORD} \
            --env spring_rabbitmq_listener_prefetch=${PREFETCH_COUNT} \
            --env spring_rabbitmq_listener_transaction-size=${PREFETCH_COUNT} \
            --env spring_rabbitmq_listener_concurrency=${CONCURRENCY} \
            --env spring_rabbitmq_listener_max-concurrency=${CONCURRENCY} \
            --env spring_rabbitmq_cache_channel_size=${CONCURRENCY} \
            --env consumer_modvalue=${MOD_COUNT} \
            --interactive  \
            --name amqp-consumer \
            --network host \
            --rm \
            --tty \
            kurron/amqp-bare-metal-consumer:latest"

echo ${CMD}
${CMD}
