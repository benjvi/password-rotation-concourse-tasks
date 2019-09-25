#!/bin/bash
set -euo pipefail

CREDENTIAL_IDS="director_credentials"
TILE_INSTALLATION_NAME="p-bosh"
JOB_INSTALLATION_NAME="director"


cd installation_settings_input

for credential_id in $CREDENTIAL_IDS; do
  cat installation_settings.json | jq "del(.products[]| select(.installation_name == \"$TILE_INSTALLATION_NAME\")| .jobs[] | select(.installation_name == \"$JOB_INSTALLATION_NAME\")| .properties[] | select(.identifier == "$credential_id"))" > installation_settings.json
  set +e
  cat installation_settings.json | grep -n $credential_id && echo "WARNING: $credential_id still exists in installation settings"
  set -e
done

mv installation_settings.json ../installation_settings_filtered/installation_settings.json

