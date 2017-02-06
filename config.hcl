backend "file" {
  path = "/vault/db/"
  default_lease_ttl = "8760h"
}

listener "tcp" {
  address = "127.0.0.1:8200"
  tls_disable = 1
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_cert_file = "/vault/certs/vault-central.crt"
  tls_key_file = "/vault/certs/vault-central.key"
}
