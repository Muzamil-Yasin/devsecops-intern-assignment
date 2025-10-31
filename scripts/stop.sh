#!/usr/bin/env bash
set -euo pipefail

# Get AWS account ID dynamically
ACCOUNT_ID=$(aws sts get-caller-identity --region us-east-1 --query Account --output text)
ECR_REGISTRY="$ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com"

# Authenticate Docker to ECR
aws ecr get-login-password --region us-east-1 \
  | docker login --username AWS --password-stdin "$ECR_REGISTRY"

# Get repository URI dynamically
REPOSITORY_URI=$(aws ecr describe-repositories \
  --region us-east-1 \
  --repository-names devsecops-intern-assignment \
  --query 'repositories[0].repositoryUri' \
  --output text)

CONTAINER_NAME=$(basename "$REPOSITORY_URI")

echo "Stopping and removing old container: $CONTAINER_NAME..."
docker stop "$CONTAINER_NAME" || true
docker rm "$CONTAINER_NAME" || true
