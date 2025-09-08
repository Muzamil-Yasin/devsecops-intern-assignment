#!/usr/bin/env bash
set -euo pipefail

# Get repository URI dynamically
REPOSITORY_URI=$(aws ecr describe-repositories \
  --repository-names devsecops-intern-assignment \
  --query 'repositories[0].repositoryUri' \
  --output text)

CONTAINER_NAME=$(basename "$REPOSITORY_URI")

echo "Stopping and removing old container: $CONTAINER_NAME..."
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true
