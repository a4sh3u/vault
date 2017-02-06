#!/bin/sh

# Run Vault Server with custom config
#################
# vault server -config=/vault/config/config.hcl &
#################

# Initialize the vault server
export VAULT_ADDR=http://127.0.0.1:8200
vault init -address=${VAULT_ADDR} > /vault/logs/keys.txt

# Unseal the vault server
vault unseal -address=${VAULT_ADDR} $(grep 'Key 1:' /vault/logs/keys.txt | awk '{print $NF}')
vault unseal -address=${VAULT_ADDR} $(grep 'Key 2:' /vault/logs/keys.txt | awk '{print $NF}')
vault unseal -address=${VAULT_ADDR} $(grep 'Key 3:' /vault/logs/keys.txt | awk '{print $NF}')

# Vault authenticate and log in
vault auth $(grep 'Initial Root Token:' /vault/logs/keys.txt | awk '{print $NF}')
# Enable auditing
vault audit-enable -address=${VAULT_ADDR} file path=/vault/logs/vault_audit.log
#
