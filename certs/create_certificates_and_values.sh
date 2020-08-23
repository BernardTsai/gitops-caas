#!/usr/bin/env bash

# determine location of this script and change to that directory
export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

# define DNS context
export DNSNAME=cluster.local
export CONTEXT=identity.linkerd.$DNSNAME

# create trust anchor certificate
step certificate create $CONTEXT ca.crt ca.key \
  --profile root-ca \
  --no-password --insecure --not-after 87600h

# create issuer certificate and key
step certificate create $CONTEXT issuer.crt issuer.key \
  --profile intermediate-ca \
  --ca ca.crt --ca-key ca.key \
  --no-password --insecure --not-after 8760h

# create values.yaml
cat > $DIR/../helm/values.yaml << EOF
linkerd2:
  global:
      # ca.crt
    identityTrustAnchorsPEM: |
EOF

awk '{print "      " $0}' ca.crt >> $DIR/../helm/values.yaml

cat >> $DIR/../helm/values.yaml << EOF
  identity:
    issuer:
      tls:
        # issuer.crt
        crtPEM: |
EOF

awk '{print "          " $0}' issuer.crt >> $DIR/../helm/values.yaml

cat >> $DIR/../helm/values.yaml << EOF
        # issuer.key
        keyPEM: |
EOF

awk '{print "          " $0}' issuer.key >> $DIR/../helm/values.yaml


cat >> $DIR/../helm/values.yaml << EOF
      crtExpiry: DATE
EOF
