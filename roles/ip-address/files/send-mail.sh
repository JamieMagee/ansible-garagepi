#!/bin/bash

set -o allexport
source .env
set +o allexport

export IFS=","
for RECIPIENT in $RECIPIENTS; do
  curl -s --user "$MAILGUN_API_KEY" \
    https://api.mailgun.net/v3/"$MAILGUN_DOMAIN"/messages \
    -F from="$SENDER" \
    -F to="$RECIPIENT" \
    -F subject="New IP Address" \
    -F text="$(ip addr)"
done