```
install helm to user of kubernetes:

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm version

helm repo add stable https://charts.helm.sh/stable
helm repo add bitnami  https://charts.bitnami.com/bitnami
helm repo update

helm search repo stable | grep harchi
or
helm search repo bitnami | grep harchi

install & uninstall chart:
helm install "ye esmi bayad bedim" esme chart
helm uninstall esme chart
baresi chartaii ke nasb shode:
helm ls

kubectl get pod
"chizi ke nasb kardim bayad biare"
```
