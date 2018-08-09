#!/usr/bin/env bash

# build info 1.0
# projectUrl :string
# message :string
# passed :boolean

bot_url="http://localhost:8080/builds/info"
project_url=$CIRCLE_BUILD_URL
passed=$1
message="$CIRCLE_JOB - Build Info\nUser: $CIRCLE_USERNAME\nCommit: $CIRCLE_SHA1\nRepository: $CIRCLE_REPOSITORY_URL"

echo 'Sending HTTP request for Build Info to your personal bot'
curl --silent \
 -H "Content-Type: application/json" \
 -H "Authorization: $BOT_ACCESS_TOKEN" "$bot_url" \
 -d "{ \"projectUrl\": \"$project_url\", \"passed\": \"$passed\", \"message\": \"$message\"}"