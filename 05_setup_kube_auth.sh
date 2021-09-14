#!/bin/bash
set -e
echo "Configuring Kubernetes authentication"
kubectl exec -ti vault-0 -n vault -- vault auth enable kubernetes
kubectl exec -ti vault-0 -n vault -- sh -c 'vault write auth/kubernetes/config \
                                                    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
                                                    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
                                                    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt'

kubectl exec -ti vault-0 -n vault -- sh -c 'echo '"'"'path "secret/data/webapp/config" {
   capabilities = ["read"]
}
   '"'"'> /tmp/policy.webapp.hcl'

kubectl exec -ti vault-0 -n vault -- sh -c 'vault policy write webapp /tmp/policy.webapp.hcl'
kubectl exec -ti vault-0 -n vault -- sh -c 'vault write auth/kubernetes/role/webapp \
                                                    bound_service_account_names=vault \
                                                    bound_service_account_namespaces=default \
                                                    policies=webapp \
                                                    ttl=24h'
