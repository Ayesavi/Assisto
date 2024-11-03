#!/bin/bash

# Function to deploy to dev environment
deploy_dev() {
    echo "Deploying to dev environment (assisto-dev-52a1d)..."
    gcloud functions deploy sendNotification \
      --project=assisto-dev-52a1d \
      --entry-point sendNotification \
      --runtime nodejs18 \
      --trigger-topic user-notifications \
      --region asia-south1 \
      --allow-unauthenticated
}

# Function to deploy to prod environment
deploy_prod() {
    echo "Deploying to prod environment (dev-assisto)..."
    gcloud functions deploy sendNotification \
      --project=dev-assisto \
      --entry-point sendNotification \
      --runtime nodejs18 \
      --trigger-topic user-notifications \
      --region asia-south1 \
      --allow-unauthenticated
}

# Check the argument passed
if [ "$1" == "dev" ]; then
    deploy_dev
elif [ "$1" == "prod" ]; then
    deploy_prod
else
    echo "Invalid argument. Use 'dev' or 'prod'."
    exit 1
fi
