# All curl commands that can be executed from a server to query vault server for secrets
export VAULT_ADDR=http://192.168.178.6:8200
export VAULT_TOKEN=cd80f547-e47c-8cca-c655-57df5d8281db

# Get health of vault server
curl -s -H "X-Vault-Token: $VAULT_TOKEN" -X GET $VAULT_ADDR/v1/sys/health

#
curl -s -H "X-Vault-Token: $VAULT_TOKEN" -X GET $VAULT_ADDR/v1/sys/raw/check
