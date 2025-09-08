#!/usr/bin/env bash
set -euo pipefail

# Get repository URI dynamically
REPOSITORY_URI=$(aws ecr describe-repositories \
  --repository-names devsecops-intern-assignment \
  --query 'repositories[0].repositoryUri' \
  --output text)

CONTAINER_NAME=$(basename "$REPOSITORY_URI")
IMAGE="$REPOSITORY_URI:latest"
PORT=80

echo "Running new container $CONTAINER_NAME from image $IMAGE..."
docker run -d --name $CONTAINER_NAME -p $PORT:3000 $IMAGE
