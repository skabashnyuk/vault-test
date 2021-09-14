while [ "$(kubectl get pods -l app.kubernetes.io/name=vault -n vault -o jsonpath='{.items[*].status.phase}')" != "Running" ]; do
   sleep 5
   echo "Waiting for vault to be ready."
done

kubectl exec -ti vault-0 -n vault -- sh -c 'vault operator init > /tmp/keys.txt'
kubectl exec -ti vault-0 -n vault -- sh -c 'vault operator unseal $(grep -h '"'"'Unseal Key 1'"'"'  /tmp/keys.txt | awk '"'"'{print $NF}'"'"')'
kubectl exec -ti vault-0 -n vault -- sh -c 'vault operator unseal $(grep -h '"'"'Unseal Key 2'"'"'  /tmp/keys.txt | awk '"'"'{print $NF}'"'"')'
kubectl exec -ti vault-0 -n vault -- sh -c 'vault operator unseal $(grep -h '"'"'Unseal Key 3'"'"'  /tmp/keys.txt | awk '"'"'{print $NF}'"'"')'

echo "init complete"