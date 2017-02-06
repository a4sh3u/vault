# All curl commands that can be executed from a server to query vault server for secrets
export VAULT_ADDR=https://192.168.178.6:8200
export VAULT_TOKEN=499d32f9-5f98-3f74-751d-a0a8c104185f

# Get health of vault server
curl -X GET --cacert ./vault-central.crt -H "X-Vault-Token: $VAULT_TOKEN" -X GET $VAULT_ADDR/v1/sys/health
