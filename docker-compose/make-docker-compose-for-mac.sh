#!/bin/bash
# cat services.env | sed "s/127.0.0.1/docker.for.mac.localhost/g" | sed "s/0.0.0.0/docker.for.mac.localhost/g"  > services.boot2docker.env
cat docker-compose.yml | sed "s/127.0.0.1/docker.for.mac.localhost/g" | sed "s/0.0.0.0/docker.for.mac.localhost/g" | sed "s/services.env/services.boot2docker.env/g"  > docker-compose.mac.yml


echo "wrote docker-compose.mac.yml"
echo "to use it type: docker-compose -f docker-compose.mac.yml <command>"
