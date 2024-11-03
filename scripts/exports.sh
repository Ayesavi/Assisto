#!/bin/bash

# Specify the path to your JSON file
JSON_FILE="global-vars/globals.json"

# Parse the JSON file and export each key-value pair
while IFS="=" read -r key value; do
    # Trim leading/trailing spaces
    key=$(echo $key | xargs)
    value=$(echo $value | xargs)

    # Handle special characters in the value (especially for connection strings)
    value=$(echo $value | sed 's/^"\(.*\)"$/\1/')

    # Export the key-value pair as an environment variable
    export $key="$value"
    echo "Exporting $key"
done < <(jq -r 'to_entries[] | "\(.key)=\(.value)"' $JSON_FILE)
