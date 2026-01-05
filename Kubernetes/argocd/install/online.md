https://devopscube.com/setup-argo-cd-using-helm/

```
online
=======
helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd --namespace argo

#edit values.yaml 
enable high availability for production environments:
yaml
Copy code
controller:
  replicas: 3
server:
  replicas: 2

#Before deploying you need to update NodePort configurations in the helm chart so that you can access Argo CD UI in the browser, for that use the below command to save the default values of the helm chart in a YML file.

#helm show values argo/argo-cd > values.yaml
#Make changes in the service configuration block. Change the type from ClusterIP to NodePort as shown in the below image. It is responsible for exposing the Argo CD server UI. The deafult nodePort is 30080. You can customize that as well.



#Modify the values.yaml file to point to your local registry.
global:
  image:
    repository: mylocalregistry.com/argoproj/argocd
    tag: v2.8.3

controller:
  image:
    repository: mylocalregistry.com/argoproj/argocd
    tag: v2.8.3

server:
  image:
    repository: mylocalregistry.com/argoproj/argocd
    tag: v2.8.3

repoServer:
  image:
    repository: mylocalregistry.com/argoproj/argocd
    tag: v2.8.3

dex:
  image:
    repository: mylocalregistry.com/dexidp/dex
    tag: v2.37.0
redis
  image:
    repository: mylocalregistry.com/redis/redis
    tag: v7.4.1-alpine

```


kubectl edit svc -n argo argocd-server
```
apiVersion: v1
kind: Service
metadata:
  annotations:
    meta.helm.sh/release-name: argocd
    meta.helm.sh/release-namespace: argo
  creationTimestamp: "2026-01-05T13:51:25Z"
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/instance: argocd
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/name: argocd-server
    app.kubernetes.io/part-of: argocd
    app.kubernetes.io/version: v3.2.3
    helm.sh/chart: argo-cd-9.2.4
  name: argocd-server
  namespace: argo
  resourceVersion: "934908"
  uid: fa58679d-9348-477d-8bcd-58d52fc5f753
spec:
  clusterIP: 10.233.9.229
  clusterIPs:
  - 10.233.9.229
  externalTrafficPolicy: Cluster
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - name: http
    nodePort: 30080
    port: 80
    protocol: TCP
    targetPort: 8080
  - name: https
    nodePort: 30443
    port: 443
    protocol: TCP
    targetPort: 8080
  selector:
    app.kubernetes.io/instance: argocd
    app.kubernetes.io/name: argocd-server
  sessionAffinity: None
  type: NodePort
status:
  loadBalancer: {}
```

password admin:
```
kubectl -n argo get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```
