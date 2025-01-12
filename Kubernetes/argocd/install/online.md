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
