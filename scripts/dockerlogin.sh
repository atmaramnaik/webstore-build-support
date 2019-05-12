#!/usr/bin/env bash
docker login --username ${username} --password $(cat /var/go/secrets/password.txt)