#!/usr/bin/env bash
set -euo pipefail

REPOSITORY_URI=$(cat repository.txt)
CONTAINER_NAME=$(basename $REPOSITORY_URI)
IMAGE="$REPOSITORY_URI:latest"
PORT=80  # Map container port 3000 to host port 80

echo "Running new container $CONTAINER_NAME from image $IMAGE..."
docker run -d --name $CONTAINER_NAME -p $PORT:3000 $IMAGE
