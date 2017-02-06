FROM alpine:3.4
MAINTAINER Ashu

ENV VAULT_VERSION=0.6.4
ENV VAULT_TMP /tmp/vault.zip

# Vault Installation
RUN apk --no-cache add bash ca-certificates wget && \
    wget --quiet --output-document=${VAULT_TMP} https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    unzip ${VAULT_TMP} -d /bin && \
    rm -f ${VAULT_TMP}

# Vault user and associated directory creation
RUN addgroup vault && \
    adduser -S -G vault vault && \
    mkdir -p /vault/logs && \
    mkdir -p /vault/db && \
    mkdir -p /vault/config && \
    mkdir -p /vault/certs && \
    chown -R vault:vault /vault

ADD config.hcl /vault/config/config.hcl
ADD init.sh /vault/config/init.sh
ADD policies/ /vault/config/policies/
ADD certs/ /vault/certs/

RUN chmod 0755 /vault/config/init.sh

VOLUME /vault/logs
VOLUME /vault/db

EXPOSE 8200

ENTRYPOINT ["/bin/vault"]
CMD ["version"]
