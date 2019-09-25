#!/bin/bash
set -euo pipefail

echo "Credential IDs: $CREDENTIAL_IDS"
cd installation_settings_input

for credential_id in ${CREDENTIAL_IDS}; do
  echo "Removing: $credential_id"
  cat installation_settings.json | jq "del(.products[]| select(.installation_name == \"$TILE_INSTALLATION_NAME\")| .jobs[] | select(.installation_name == \"$JOB_INSTALLATION_NAME\")| .properties[] | select(.identifier == \"$credential_id\"))" > tmp
  cat tmp > installation_settings.json
  set +e
  cat installation_settings.json | grep -n $credential_id && echo "WARNING: $credential_id still exists in installation settings"
  set -e
done

cp installation_settings.json ../installation_settings_output/installation_settings.json

