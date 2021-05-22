#!/bin/bash

docker build -t asgi_test .
docker-compose up --remove-orphans --scale locust-worker=5