#!/usr/bin/env bash
set -euo pipefail
export AWS_DEFAULT_REGION=us-east-1

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_REGISTRY="$ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com"

aws ecr get-login-password --region us-east-1 \
  | docker login --username AWS --password-stdin "$ECR_REGISTRY"

REPOSITORY_URI=$(aws ecr describe-repositories \
  --region us-east-1 \
  --repository-names devsecops-intern-assignment \
  --query 'repositories[0].repositoryUri' \
  --output text)

CONTAINER_NAME=$(basename "$REPOSITORY_URI")
IMAGE="$REPOSITORY_URI:latest"
PORT=80

echo "Pulling latest image..."
docker pull "$IMAGE"

echo "Running new container $CONTAINER_NAME from image $IMAGE..."
docker run -d --name "$CONTAINER_NAME" -p $PORT:3000 "$IMAGE"
