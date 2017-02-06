openssl genrsa -out certs/rootCA.key 4096
openssl req -x509 -new -nodes -key certs/rootCA.key -sha256 -days 3650 -out certs/rootCA.pem


openssl genrsa -out certs/vault-central.key 4096
openssl req -new -key certs/vault-central.key -out certs/vault-central.csr
openssl x509 -req -in certs/vault-central.csr -CA certs/rootCA.pem -CAkey certs/rootCA.key -CAcreateserial -out certs/vault-central.crt -days 3650 -sha256








#openssl req -newkey rsa:2048 -nodes -keyout ./certs/vault-central.key -x509 -days 3650 -out ./certs/vault-central.crt
