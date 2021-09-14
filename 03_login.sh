while [ "$(kubectl get pods -l app.kubernetes.io/name=vault -n vault -o jsonpath='{.items[*].status.phase}')" != "Running" ]; do
   sleep 5
   echo "Waiting for vault to be ready."
done

kubectl exec -ti vault-0 -n vault -- sh -c 'vault login $(grep -h '"'"'Initial Root Token'"'"' /tmp/keys.txt | awk '"'"'{print $NF}'"'"')'
kubectl exec -ti vault-0 -n vault -- sh -c 'vault audit enable file file_path=/vault/logs/$(date '"'"'+%Y%m%d%H%M.%S'"'"').log.json'
