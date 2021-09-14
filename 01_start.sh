minikube stop && minikube delete
minikube start --cpus 4

kubectl create namespace vault
helm install vault hashicorp/vault --create-namespace  --namespace vault
kubectl rollout status deployment/vault-agent-injector -n vault
while [ "$(kubectl get pods -l app.kubernetes.io/name=vault -n vault -o jsonpath='{.items[*].status.phase}')" != "Running" ]; do
   sleep 5
   echo "Waiting for vault to be ready."
done
echo "start complete"