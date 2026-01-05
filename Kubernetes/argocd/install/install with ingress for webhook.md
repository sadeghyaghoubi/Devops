اگر بخوای آرگو رو به یک webhook متصل کنی حتما باید با ingress بیاری بالا پس قبل از هرچیزی باید ingress نصب شده باشه که ما فقط یک رول به ingress اضافه کنیم .


```
helm installation with ingress
---------------------------------------------
#You can also download the whole helm chart with every file use the below command
$helm fetch argo/argo-cd
#This command will download every file of the helm chart in a .tgz package, run the below command to extract the file
tar xvfz argo-cd-7.7.11.tgz
cd argo-cd

edit values.yaml  set :
## Globally shared configuration
global:
  # -- Default domain used by all components
  ## Used for ingresses, certificates, SSO, notifications, etc.
  domain: argocd.shahkar.co

and 

$helm install argocd . --values values.yaml --namespace argo  --set server.ingress.enabled=true   --set server.ingress.hosts{0}=argocd.shahkar.co   --set server.ingress.tls{0}.hosts{0}=argocd.shahkar.co   --set server.ingress.tls{0}.secretName=argocd-tls-secret

edit /etc/hosts in windows Add : 
192.168.59.34 argocd.shahkar.co

kubectl get svc -n argo | grep argocd-server
argocd-server                      NodePort    10.106.82.144    <none>        80:30080/TCP,443:30443/TCP   6m32s

for view argo dashboard : 
https://argocd.shahkar.co:30443/



config webhook in gitlab: 
-------------------

#create project in git 
#in project create directory app1 and push yamls in app1

#configure webhook in this project: 
go to project and -----> setting -----> webhooks -----> create

***************
kubectl get svc -n nginx-ingress
NAME            TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
nginx-ingress   NodePort   10.108.220.56   <none>        80:31987/TCP,443:31093/TCP   18h
***************

kubectl edit svc -n argo argocd-server



apiVersion: v1
kind: Service
metadata:
  annotations:
    meta.helm.sh/release-name: argocd
    meta.helm.sh/release-namespace: argo
  creationTimestamp: "2025-06-09T11:43:22Z"
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/instance: argocd
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/name: argocd-server
    app.kubernetes.io/part-of: argocd
    app.kubernetes.io/version: v3.0.2
    helm.sh/chart: argo-cd-8.0.6
  name: argocd-server
  namespace: argo
  resourceVersion: "58113328"
  uid: 3a2d8e1b-167c-4149-8eb4-1452452e3bce
spec:
  clusterIP: 10.106.224.44
  clusterIPs:
  - 10.106.224.44
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


URL : https://argocd.shahkar.co:31093/api/webhook
#trigger Mark all
> enable ssl


create APP in Argo dashboard
--------------------
Application Name ---> app1

Project Name ---> default

Sync Policy ---->automatic

enable ---->  Prune Resources  and Self Heal and Auto-Create Namespace


Repository URL: ----> http://192.168.59.36/root/shahkar.git


Path  -----> is directory in repository address for example app1

Cluster URL ---- > https://kubernetes.default.svc

Namespace ----> for example websever

```
