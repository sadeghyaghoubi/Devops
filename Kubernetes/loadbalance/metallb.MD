metallb installation
================================

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.10/config/manifests/metallb-native.yaml

تعریف رنج IP که MetalLB بتونه استفاده کنه:

# metallb-config.yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: my-ip-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.1.240-192.168.1.250
###-------> you can set workers ip
###or 
###set one of workers
###worker1-or worker2-or worker3 address -----> 192.168.59.68/32
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: l2adv
  namespace: metallb-system


kubectl apply -f metallb-config.yaml


--------------------
so finaly test
---------------
[root@master1 ~]# kubectl get svc -n nginx-ingress
NAME            TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
nginx-ingress   LoadBalancer   10.99.83.137   192.168.59.68   80:31855/TCP,443:31854/TCP   3d2h


[root@master1 ~]# kubectl get ingress -n kasra front-portal-ingress
NAME                   CLASS   HOSTS              ADDRESS         PORTS   AGE
front-portal-ingress   nginx   portal.kuber.com   192.168.59.68   80      3d20h

