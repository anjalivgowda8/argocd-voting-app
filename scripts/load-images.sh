#!/bin/bash

set -e

minikube image load vote:latest

minikube image load result:latest

minikube image load worker:latest