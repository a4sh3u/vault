# SETUP THE DOCKER VAULT CONTAINER
docker build . -t ashu/vault:0.1
docker run -tid --name vault -p 8200:8200 ashu/vault:0.1 server -config=/vault/config/config.hcl
docker exec -ti vault /vault/config/init.sh
docker exec -ti vault cat /vault/logs/keys.txt

##############################
# Vault status - From inside the container
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
vault policy-write production /vault/config/policies/production.hcl
vault policy-write staging /vault/config/policies/staging.hcl
vault policy-write integration /vault/config/policies/integration.hcl
##############################
# Role Creation
vault write auth/token/roles/integration period="8760h" allowed_policies="integration"
vault write auth/token/roles/staging period="8760h" allowed_policies="staging"
vault write auth/token/roles/production period="8760h" allowed_policies="production"
##############################
# Token Creation
# Wrap
vault token-create -num_uses=10 -policy=production,default -wrap-ttl=20m

vault path-help sys

CURL_OPT="-H X-Vault-Token:$VAULT_TOKEN -X POST"
curl ${CURL_OPT} $VAULT_ADDR/v1/sys/mounts/postgresql -d '{"type":"postgresql"}'













# VAULT UI's
Horrible
docker run -p 80:80 -e VAULT_ADDR=http://192.168.178.6:8200 nyxcharon/vault-ui:latest
docker run -d -p 8000:8000 --name vault-ui djenriquez/vault-ui
