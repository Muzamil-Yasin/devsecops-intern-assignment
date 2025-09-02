#!/usr/bin/env bash
set -euo pipefail

# Derive container name from REPOSITORY_URI
# Example: 637423405167.dkr.ecr.us-east-1.amazonaws.com/surge-repo -> surge-repo
CONTAINER_NAME=$(basename $REPOSITORY_URI)

if docker ps -q --filter "name=$CONTAINER_NAME" | grep -q .; then
    echo "Stopping existing container $CONTAINER_NAME..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
else
    echo "No existing container to stop."
fi
