## Minikube based demo of hashicorp vault capabilities

## Prerequisites
1. minikube
2. helm
3. `helm repo add hashicorp https://helm.releases.hashicorp.com`

## Demo
1. `01_start.sh` - to start new k8s cluster on minikube and deploy vault.
2. `02_init_and_unseale.sh` - initialise and unseal vault.
3. `03_login.sh` - login and enable audit log in `/vault/logs/XXXXXXX.log.json`.
4. `04_test_secrets.sh` - demoed work with vault's key-values.
5. `05_setup_kube_auth.sh` - configure kube authentication with SA for web application.
6. `06_test_web.sh` - deploy sample web app and open port forward to localhost:8080
7. Open in browser `http://localhost:8080`. You should see secrets created on `04_test_secrets.sh` that was read web application using k8s SA create with `05_setup_kube_auth.sh` 