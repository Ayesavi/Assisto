#!/bin/bash

source ./scripts/exports.sh
# Function to display usage information
usage() {
    echo "Usage: $0 [init|reset|fetchChanges|pushChanges|pull] [optional: diff_name]"
    exit 1
}

# Function to initialize Supabase project linking and pull the database schema
init() {
    # Check if the necessary environment variables are set
    if [ -z "$PROD_REF" ] || [ -z "$PROD_DB_PASSWORD" ]; then
        echo "Error: PROD_REF and PROD_DB_PASSWORD must be set."
        exit 1
    fi

    echo "Linking Supabase project..."
    supabase link --project-ref $PROD_REF --password $PROD_DB_PASSWORD

    echo "Pulling the database schema..."
    supabase db pull

    echo "Initialization complete."
}

# Function to reset the database
reset() {
    echo "Resetting the Supabase database..."
    supabase db reset
    echo "Database reset complete."
}

# Function to fetch changes (diff)
fetchChanges() {
    local DIFF_NAME=$1

    if [ -z "$DIFF_NAME" ]; then
        echo "Error: You must provide a diff name."
        usage
    fi

    if [ -z "$DEV_DB_URL" ]; then
        echo "Error: DEV_DB_URL must be set."
        exit 1
    fi

    echo "Fetching database changes and creating diff with name: $DIFF_NAME"
    supabase db diff --db-url $DEV_DB_URL -f $DIFF_NAME

    echo "Database changes fetched and saved as $DIFF_NAME."
}

# Function to push changes to the database
pushChanges() {
    echo "Pushing changes to the database..."
    supabase db push
    echo "Database changes pushed."
}

# Function to pull the database schema
pull() {
    echo "Pulling the latest database schema..."
    supabase db pull
    echo "Database schema pulled."
}

# Main script logic
if [ $# -lt 1 ]; then
    usage
fi

COMMAND=$1
DIFF_NAME=$2

case $COMMAND in
    init)
        init
        ;;
    reset)
        reset
        ;;
    fetchchanges)
        fetchChanges $DIFF_NAME
        ;;
    pushchanges)
        pushChanges
        ;;
    pull)
        pull
        ;;
    *)
        usage
        ;;
esac
