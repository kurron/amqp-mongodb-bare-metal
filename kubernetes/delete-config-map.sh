#!/bin/bash

CONFIGURATION=amqp-mongodb-bare-metal-producer-configuration

DELETE="kubectl delete configmap ${CONFIGURATION}"

echo ${DELETE}
${DELETE}
