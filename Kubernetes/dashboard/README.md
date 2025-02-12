https://medium.com/@howdyservices9/setting-up-kubernetes-dashboard-a-step-by-step-guide-9c479a487001



# Setting Up Kubernetes Dashboard

## Deploy Kubernetes Dashboard

Apply the recommended deployment manifest:

```sh
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
```

## Create Admin User

Create a service account for the dashboard:

```yaml
# dashboard-adminuser.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
```

Create a ClusterRoleBinding for the admin user:

```yaml
# dashboard-clusterrole.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: admin-user
    namespace: kubernetes-dashboard
```

Create a secret to store the token:

```yaml
# dashboard-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
  annotations:
    kubernetes.io/service-account.name: "admin-user"
type: kubernetes.io/service-account-token
```

## Apply the Configurations

```sh
kubectl apply -f dashboard-adminuser.yaml -n kubernetes-dashboard
kubectl apply -f dashboard-clusterrole.yaml -n kubernetes-dashboard
kubectl apply -f dashboard-secret.yaml -n kubernetes-dashboard
```

## Expose the Dashboard with NodePort

```sh
kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard -p '{"spec":{"type":"NodePort"}}'
kubectl get svc kubernetes-dashboard -n kubernetes-dashboard
```

Now, access the dashboard using:

```
https://<NodeIP>:<NodePort>
```

## Retrieve the Admin Token

```sh
kubectl get secret admin-user -n kubernetes-dashboard -o jsonpath={".data.token"} | base64 -d
```

Use the extracted token to log in to the Kubernetes Dashboard.

---

This guide provides a step-by-step approach to setting up and accessing the Kubernetes Dashboard.
