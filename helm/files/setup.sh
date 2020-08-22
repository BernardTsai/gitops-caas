#!/usr/bin/env bash

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
