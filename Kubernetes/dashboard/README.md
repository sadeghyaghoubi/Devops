https://medium.com/@howdyservices9/setting-up-kubernetes-dashboard-a-step-by-step-guide-9c479a487001

dashboard kubernetes:

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

vim dashboard-adminuser.yaml:
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
  
  
vim dashboard-clusterrole.yaml:
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
	

vim dashboard-secret.yaml :
apiVersion: v1
kind: Secret
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
  annotations:
    kubernetes.io/service-account.name: "admin-user"
type: kubernetes.io/service-account-token




kubectl apply -f dashboard-adminuser.yaml -n kubernetes-dashboard
kubectl apply -f dashboard-clusterrole.yaml -n kubernetes-dashboard
kubectl apply -f dashboard-secret.yaml -n kubernetes-dashboard

kubectl patch svc kubernetes-dashboard -n kubernetes-dashboard -p '{"spec":{"type":"NodePort"}}'
kubectl get svc kubernetes-dashboard -n kubernetes-dashboard
https://<NodeIP>:nodeport


kubectl get secret admin-user -n kubernetes-dashboard -o jsonpath={".data.token"} | base64 -d

