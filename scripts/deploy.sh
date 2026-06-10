#!/bin/bash

set -e

echo "Building Docker Images..."

./scripts/build-images.sh

echo "Loading Images into Minikube..."
