backend "file" {
  path = "/vault/db/"
  default_lease_ttl = "8760h"
}

listener "tcp" {
  address = "192.168.178.6:8200"
  tls_cert_file = "/vault/certs/vault-central.crt"
  tls_key_file = "/vault/certs/vault-central.key"
}
