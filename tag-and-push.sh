#!/bin/bash

# use the time as a tag
UNIXTIME=$(date +%s)

# docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
docker tag amqpmongodbbaremetal_benchmark:latest kurron/amqp-mongodb-bare-metal:latest
docker tag amqpmongodbbaremetal_benchmark:latest kurron/amqp-mongodb-bare-metal:${UNIXTIME}
docker images

# Usage:  docker push [OPTIONS] NAME[:TAG]
docker push kurron/amqp-mongodb-bare-metal:latest
docker push kurron/amqp-mongodb-bare-metal:${UNIXTIME}
