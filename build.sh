#!/usr/bin/env bash

docker build -t sgaunet/alpine-sshd:latest .
rc=$?

if [ "$rc" != "0" ]
then
    echo "FAILED"
    exit 1
fi

docker push sgaunet/alpine-sshd:latest