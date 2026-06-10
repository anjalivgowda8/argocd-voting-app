#!/bin/bash

set -e

docker build -t vote:latest ./vote

docker build -t result:latest ./result

docker build -t worker:latest ./worker