#!/bin/bash
set -euo pipefail

# NB, in the past the format of this config has changed between major versions of opsman
om --env env/"${ENV_FILE}" curl -x PUT --path https://ops_manager/api/v0/staged/director/properties -d '{"director_configuration":{"bosh_recreate_on_next_deploy": false}}'
