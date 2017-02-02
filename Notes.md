# SETUP THE DOCKER VAULT CONTAINER
docker build . -t ashu/vault:0.1
docker run -tid --name vault -p 8200:8200 ashu/vault:0.1 server -config=/vault/config/config.hcl
docker exec -ti vault /vault/config/init.sh
docker exec -ti vault cat /vault/logs/keys.txt

##############################
# Vault status - From inside the container
docker exec -ti vault bash
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=$(grep 'Initial Root Token:' /vault/logs/keys.txt | awk '{print $NF}')
vault status
vault mounts
##############################
# Vault list auth methods
vault auth -methods

##############################
# Mounts creation
vault mount -path=integration -description="mount point for all integration env secrets" generic
vault mount-tune -max-lease-ttl=87600h integration
vault mount -path=staging -description="mount point for all staging env secrets" generic
vault mount-tune -max-lease-ttl=87600h staging
vault mount -path=production -description="mount point for all production env secrets" generic
vault mount-tune -max-lease-ttl=87600h production
vault mounts
##############################
# Policy creation
vault policy-write integration-policy /vault/config/policies/integration.hcl
vault policy-write staging-policy /vault/config/policies/staging.hcl
vault policy-write production-policy /vault/config/policies/production.hcl
##############################
# Role Creation
vault write auth/token/roles/integration-role period="8760h" allowed_policies="integration-policy"
vault write auth/token/roles/staging-role period="8760h" allowed_policies="staging-policy"
vault write auth/token/roles/production-role period="8760h" allowed_policies="production-policy"
##############################
# Token Creation
vault token-create -policy=integration-policy -no-default-policy -display-name=integration-token -role=integration-role  -ttl='8760h'
vault token-create -policy=staging-policy -no-default-policy -display-name=staging-token -role=staging-role  -ttl='8760h'
vault token-create -policy=production-policy -no-default-policy -display-name=production-token -role=production-role  -ttl='8760h'
##############################
# Dummy Secret Variable creation for status check for every environment
vault write integration/env value=int
vault write staging/env value=stg
vault write production/env value=prd













# VAULT UI's
Horrible
docker run -p 80:80 -e VAULT_ADDR=http://192.168.178.6:8200 nyxcharon/vault-ui:latest
docker run -d -p 8000:8000 --name vault-ui djenriquez/vault-ui
