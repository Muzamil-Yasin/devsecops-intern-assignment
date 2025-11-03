#!/usr/bin/env bash
set -euo pipefail

CONTAINER_NAME="devsecops-intern-assignment"

echo "Stopping and removing old container: $CONTAINER_NAME..."

if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    docker stop "$CONTAINER_NAME"
    docker rm "$CONTAINER_NAME"
else
    echo "No running container named $CONTAINER_NAME found."
fi
