#!/bin/bash
set -e
kubectl exec -ti vault-0 -n vault -- vault secrets enable -path=secret kv-v2
kubectl exec -ti vault-0 -n vault -- vault kv put secret/webapp/config username="static-user" password="static-password"
kubectl exec -ti vault-0 -n vault -- vault kv get secret/webapp/config
