#!/bin/sh

set -e

if [[ -z "$PORTAINER_USERNAME" ]]; then
    echo "Please define an environment variable named PORTAINER_USERNAME"
    exit 1
fi

if [[ -z "$PORTAINER_PASSWORD" ]]; then
    echo "Please define an environment variable named PORTAINER_PASSWORD"
    exit 1
fi 

if [[ -z "$APP_TO_RESTART" ]]; then
    echo "Please define an environment variable named APP_TO_RESTART"
    exit 1
fi

if [[ -z "$SERVER_AND_PORT" ]]; then
    echo "Please define an environment variable named SERVER_AND_PORT"
    exit
fi 

echo "Logging into portainer at $SERVER_AND_PORT"
JWT_TOKEN=$(http --ignore-stdin POST $SERVER_AND_PORT/api/auth Username="$PORTAINER_USERNAME" Password="$PORTAINER_PASSWORD" | jq .jwt | tr -d '"')

echo "Getting list of all stacks and filtering to find $APP_TO_RESTART"
ID=$(http --ignore-stdin GET $SERVER_AND_PORT/api/stacks "Authorization: Bearer $JWT_TOKEN" | jq ".[] | select(.Name == \"$APP_TO_RESTART\") | .Id")

echo "Stopping $APP_TO_RESTART"
http --quiet --ignore-stdin POST $SERVER_AND_PORT/api/stacks/$ID/stop "Authorization: Bearer $JWT_TOKEN"

echo "Starting $APP_TO_RESTART"
http --quiet --ignore-stdin POST $SERVER_AND_PORT/api/stacks/$ID/start "Authorization: Bearer $JWT_TOKEN"
