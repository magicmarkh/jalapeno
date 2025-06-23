#!/usr/bin/env bash
set -eux

# 2) pull platform creds from AWS Secrets Manager
secret_json=$(aws secretsmanager get-secret-value \
  --region "$AWS_REGION" \
  --secret-id "$PLATFORM_SECRET_NAME" \
  --query SecretString --output text)

client_id=$(echo "$secret_json" | jq -r .client_id)
client_secret=$(echo "$secret_json" | jq -r .client_secret)


# ─── get OAuth token from Identity tenant ─────────────────────────────────────
PLATFORM_URL="https://${TENANT_IDENTITY_ID}.id.cyberark.cloud/oauth2/platformtoken"

client_id="$client_id"
client_secret="$client_secret"
platform_token=$(curl -sk -X POST "$PLATFORM_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=${client_id}&client_secret=${client_secret}" \
  | jq -r .access_token)


cyberark_base_url="https://${IDENTITY_TENANT_NAME}"
# ─── retrieve connector-pool ID ───────────────────────────────────────────────
pools=$(curl -sk -H "Authorization: Bearer $platform_token" \
  "${cyberark_base_url}.connectormanagement.cyberark.cloud/api/connector-pools")
pool_id=$(echo "$pools" \
  | jq -r ".connectorPools[] | select(.name==\"${CONNECTOR_POOL_NAME}\") | .poolId")

# ─── generate & run the setup script ──────────────────────────────────────────

# build the JIT API URL for your tenant
JIT_API_URL="${cyberark_base_url}-jit.cyberark.cloud/api/connectors/setup-script"

# POST the JSON payload per the docs
setup_resp=$(curl -sk -X POST "$JIT_API_URL" \
  -H "Authorization: Bearer $platform_token" \
  -H "Content-Type: application/json" \
  -d '{
    "connector_type":      "AWS",
    "connector_os":        "linux",
    "connector_pool_id":   "'"${pool_id}"'",
    "expiration_minutes":  15
  }')

bash_cmd=$(echo "$setup_resp" | jq -r .bash_cmd)
eval "$bash_cmd"

# ─── clean up ─────────────────────────────────────────────────────────────────
curl -sk -X POST "$PLATFORM_URL/revoke" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "token=${platform_token}" || true

curl -sk -X POST \
  -H "Authorization: Token token=\"$conjur_token\"" \
  "$CONJUR_APPLIANCE_URL/authn/logout" || true

