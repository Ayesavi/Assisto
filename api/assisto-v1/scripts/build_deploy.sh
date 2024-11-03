#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 [build|push|deploy|buildanddeploy] [dev|prod]"
    exit 1
}

# Function to build the Docker image
build() {
    local ENV=$1
    if [ "$ENV" == "dev" ]; then
        PROJECT_ID="assisto-dev-52a1d"
    elif [ "$ENV" == "prod" ]; then
        PROJECT_ID="dev-assisto"
    else
        usage
    fi

    local IMAGE_NAME="nginx"
    local IMAGE_TAG="latest"
    local IMAGE_URI="asia.gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}"

    echo "Building Docker image..."
    docker  build -t ${IMAGE_URI} -f Dockerfile.nginx . --platform linux/amd64 

    echo "Docker image built and tagged as ${IMAGE_URI}."
}

# Function to push and tag the Docker image
push_and_tag() {
    local ENV=$1
    if [ "$ENV" == "dev" ]; then
        PROJECT_ID="assisto-dev-52a1d"
    elif [ "$ENV" == "prod" ]; then
        PROJECT_ID="dev-assisto"
    else
        usage
    fi

    local IMAGE_NAME="nginx"
    local IMAGE_TAG="latest"
    local IMAGE_URI="asia.gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}"

    echo "Authenticating with Google Cloud..."
    gcloud auth configure-docker

    echo "Pushing Docker image..."
    docker push ${IMAGE_URI}

    echo "Docker image pushed to ${IMAGE_URI}."
}

# Function to deploy the Docker image to Google Cloud Run
deploy() {
    local ENV=$1
    if [ "$ENV" == "dev" ]; then
        PROJECT_ID="assisto-dev-52a1d"
        ENVIRONMENT="development"
        CMS_API_URL="https://q1gi10dd.api.sanity.io/v2021-06-07/data/query/development"
        CLOUD_FN_URL="https://asia-south1-assisto-dev-52a1d.cloudfunctions.net/apiv1"
    elif [ "$ENV" == "prod" ]; then
        PROJECT_ID="dev-assisto"
        ENVIRONMENT="production"
        CMS_API_URL="https://q1gi10dd.api.sanity.io/v2021-06-07/data/query/production"
        CLOUD_FN_URL="https://asia-south1-dev-assisto.cloudfunctions.net/apiv1"
    else
        usage
    fi

    local IMAGE_NAME="nginx"
    local IMAGE_TAG="latest"
    local IMAGE_URI="asia.gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}"

    echo "Deploying to Google Cloud Run..."
    gcloud run deploy ${IMAGE_NAME} \
      --image ${IMAGE_URI} \
      --platform managed \
      --region asia-south1 \
      --allow-unauthenticated \
      --project ${PROJECT_ID} \
      --set-env-vars CMS_API_URL=${CMS_API_URL},CLOUD_FN_URL=${CLOUD_FN_URL}

    echo "Deployment completed for ${ENVIRONMENT} environment."
}

# Function to build, push, and deploy all in one go
build_and_deploy() {
    local ENV=$1
    build $ENV
    push_and_tag $ENV
    deploy $ENV
}

# Main script logic
if [ $# -lt 2 ]; then
    usage
fi

COMMAND=$1
ENV=$2

case $COMMAND in
    build)
        build $ENV
        ;;
    push)
        push_and_tag $ENV
        ;;
    deploy)
        deploy $ENV
        ;;
    buildanddeploy)
        build_and_deploy $ENV
        ;;
    *)
        usage
        ;;
esac
