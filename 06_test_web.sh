#!/bin/bash
set -e
echo "Configuring Kubernetes authentication"
kubectl apply -n vault --filename web/deployment-01-webapp.yml
kubectl rollout status deployment/webapp -n vault
kubectl port-forward  -n vault \
    $(kubectl get pod -l app=webapp -n vault -o jsonpath="{.items[0].metadata.name}") \
    8080:8080