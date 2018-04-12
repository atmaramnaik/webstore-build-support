#!/bin/bash

echo -n "trying boot2docker... "
INTERNAL_HOST_IP="`boot2docker ip 2>/dev/null`"
if [ $? -gt 0 ] ; then
    echo "FAILED"
    echo -n "trying docker-machine... "
    DOCKER_MACHINE_NAME="`docker-machine ls -q --filter="state=Running"`"
    if [ $? -gt 0 ] ; then
	echo "FAILED"
	echo "You need to have either a boot2docker vm or a docker-machine vm running."
	exit 1
    fi
    INTERNAL_HOST_IP="`docker-machine ip $DOCKER_MACHINE_NAME`"
fi

if [[ ! "$INTERNAL_HOST_IP" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    echo "FAILED"
    echo "found IP '$INTERNAL_HOST_IP' is invalid"
    exit 1
fi
echo "SUCCESS"
echo "using internal host ip $INTERNAL_HOST_IP"

# cat services.env | sed "s/127.0.0.1/$INTERNAL_HOST_IP/g" | sed "s/localhost/$INTERNAL_HOST_IP/g" | sed "s/0.0.0.0/$INTERNAL_HOST_IP/g"  > services.boot2docker.env
cat docker-compose.yml | sed "s/127.0.0.1/$INTERNAL_HOST_IP/g" | sed "s/localhost/$INTERNAL_HOST_IP/g" | sed "s/0.0.0.0/$INTERNAL_HOST_IP/g" | sed "s/services.env/services.boot2docker.env/g"  > docker-compose.boot2docker.yml


echo "wrote docker-compose.boot2docker.yml"
echo "to use it type: docker-compose -f docker-compose.boot2docker.yml <command>"
