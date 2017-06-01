#!/bin/bash

# use the time as a tag
UNIXTIME=$(date +%s)

# docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
docker tag amqpbaremetalconsumer_consumer:latest kurron/amqp-bare-metal-consumer:latest
docker tag amqpbaremetalconsumer_consumer:latest kurron/amqp-bare-metal-consumer:${UNIXTIME}
docker images

# Usage:  docker push [OPTIONS] NAME[:TAG]
docker push kurron/amqp-bare-metal-consumer:latest
docker push kurron/amqp-bare-metal-consumer:${UNIXTIME}
