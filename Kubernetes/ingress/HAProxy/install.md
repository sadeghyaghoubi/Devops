### step 1:
install helm


### step 2 :
install ha proxy with helm :
```
*** download  image
crictl pull haproxytech/kubernetes-ingress
crictl pull haproxytech/kubernetes-ingress:1.10.2
crictl pull hashicorp/http-echo

helm repo add haproxytech https://haproxytech.github.io/helm-charts
helm repo update

*** By default, the Helm chart adds --ingress.class=haproxy to the ingress controller. 
*** That means that it will use Ingress resources only if they specify an annotation of 
*** kubernetes.io/ingress.class: haproxy. You can disable this by setting --set controller.ingressClass=null 
*** when calling helm instal
OR::::::
helm install haproxy-kubernetes-ingress haproxytech/kubernetes-ingress     --create-namespace     --namespace haproxy-controller
OR
*** Install with preset NodePort values
 helm install haproxy-kubernetes-ingress haproxytech/kubernetes-ingress     --create-namespace     --namespace haproxy-controller     --set controller.service.nodePorts.http=30000     --set controller.service.nodePorts.https=30001     --set controller.service.nodePorts.stat=30002
OR
*** Run the ingress controller as a DaemonSet
 helm install haproxy-kubernetes-ingress haproxytech/kubernetes-ingress     --create-namespace     --namespace haproxy-controller     --set controller.kind=DaemonSet     --set controller.daemonset.useHostPort=true


************************************* Install with kubectl
 kubectl apply -f https://raw.githubusercontent.com/haproxytech/kubernetes-ingress/v1.10/deploy/haproxy-ingress.yaml

*** Check your installation

# kubectl get pods --namespace haproxy-controller

  NAME                                       READY   STATUS    RESTARTS   AGE
  haproxy-kubernetes-ingress-7dd4cc4b-x5fkv  1/1     Running   0          1m


# kubectl get svc --namespace haproxy-controller

  NAME                         TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)                                     AGE
  haproxy-kubernetes-ingress   NodePort   10.104.173.167   <none>        80:30264/TCP,443:31575/TCP,1024:31785/TCP   155m
```
