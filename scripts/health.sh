#!/usr/bin/env bash
set -euo pipefail

# Use localhost and the host port mapped from Docker
APP_URL="http://127.0.0.1/"
RETRIES=10
SLEEP=3

echo "Checking if app is up at $APP_URL..."

for i in $(seq 1 $RETRIES); do
  if curl -fsS --max-time 2 "$APP_URL" >/dev/null; then
    echo "App is healthy."
    exit 0
  fi
  echo "Waiting for app to be healthy... ($i/$RETRIES)"
  sleep $SLEEP
done

echo "Health check failed."
exit 1
