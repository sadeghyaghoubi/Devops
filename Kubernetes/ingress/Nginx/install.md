```
https://docs.nginx.com/nginx-ingress-controller/installation/installing-nic/installation-with-manifests/
https://github.com/nginxinc/kubernetes-ingress

-----------------------------------------
#Clone the repository
$git clone https://github.com/nginxinc/kubernetes-ingress.git --branch <version_number>
$cd kubernetes-ingress/deployments


#Set up role-based access control (RBAC)
$kubectl apply -f common/ns-and-sa.yaml
$kubectl apply -f rbac/rbac.yaml
$kubectl apply -f rbac/ap-rbac.yaml


#Create common resources
$kubectl apply -f common/nginx-config.yaml
$kubectl apply -f common/ingress-class.yaml


#Create custom resources
$kubectl apply -f common/crds/k8s.nginx.org_virtualservers.yaml
$kubectl apply -f common/crds/k8s.nginx.org_virtualserverroutes.yaml
$kubectl apply -f common/crds/k8s.nginx.org_transportservers.yaml
$kubectl apply -f common/crds/k8s.nginx.org_policies.yaml


(((((v3.7.0
kubectl apply -f config/crd/bases/k8s.nginx.org_virtualservers.yaml
kubectl apply -f config/crd/bases/k8s.nginx.org_virtualserverroutes.yaml
kubectl apply -f config/crd/bases/k8s.nginx.org_transportservers.yaml
kubectl apply -f config/crd/bases/k8s.nginx.org_policies.yaml
kubectl apply -f config/crd/bases/k8s.nginx.org_globalconfigurations.yaml
)))))))






#Optional custom resource definitions
$kubectl apply -f common/crds/k8s.nginx.org_globalconfigurations.yaml
$kubectl apply -f common/crds/appprotect.f5.com_aplogconfs.yaml
$kubectl apply -f common/crds/appprotect.f5.com_appolicies.yaml
$kubectl apply -f common/crds/appprotect.f5.com_apusersigs.yaml
$kubectl apply -f common/crds/appprotectdos.f5.com_apdoslogconfs.yaml
$kubectl apply -f common/crds/appprotectdos.f5.com_apdospolicy.yaml
$kubectl apply -f common/crds/appprotectdos.f5.com_dosprotectedresources.yaml


#Deploy NGINX Ingress Controller Deployment
$kubectl apply -f deployment/nginx-ingress.yaml


#How to access NGINX Ingress Controller (create service)

#Option 1: Create a NodePort service

نکته مهم اینه که اگر پورت ندیم بصورت رندوم میذاره و حتما باید یک پورتی براش تعریف بشه
پس بهتره قبلش edit کنیم و بعد apply کنیم
$kubectl create -f service/nodeport.yaml



test
===============
https://github.com/nginxinc/kubernetes-ingress/tree/main/examples/ingress-resources/complete-example

apply cafee and tea yamls :
kubectl apply -f examples/ingress-resources/complete-example/*

#worker address : 192.168.59.34
$ubectl get svc -n nginx-ingress
NAME            TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
nginx-ingress   NodePort   10.108.220.56   <none>        80:31987/TCP,443:31093/TCP   131m

#set dns windows system : 
192.168.59.34 cafe.example.com

in windows : 
> https://cafe.example.com:31093/coffee

Server address: 40.40.49.91:8080
Server name: coffee-55f98c77cf-km2kc
Date: 11/Jan/2025:14:13:43 +0000
URI: /coffee
Request ID: e16fc3e4c59d1460dbcaa2a365ee1b10

> https://cafe.example.com:31093/tea

Server address: 40.40.97.62:8080
Server name: tea-7dfb4bdfc8-gxhtz
Date: 11/Jan/2025:14:16:11 +0000
URI: /tea
Request ID: d793e48c3b651a835ce5b6b47311e954







---------------------------
```
