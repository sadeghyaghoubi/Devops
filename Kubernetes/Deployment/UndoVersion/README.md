
```
kubectl get rs -n deploy-ns -o wide


NAME                          DESIRED   CURRENT   READY   AGE     CONTAINERS   IMAGES         SELECTOR
nginx-deployment-56c6c88b4b   0         0         0       27m     nginx        nginx:1.16.1   app=nginx,pod-template-hash=56c6c88b4b
nginx-deployment-56cb67986c   0         0         0       44m     nginx        nginx:1.14.2   app=nginx,pod-template-hash=56cb67986c
nginx-deployment-66bfb5c864   4         4         4       7m21s   nginx        nginx:latest   app=nginx,pod-template-hash=66bfb5c864


```
```
kubectl rollout history deployment  -n deploy-ns

deployment.apps/nginx-deployment
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
3         <none>
```
```
kubectl annotate deployments.apps -n deploy-ns nginx-deployment kubernetes.io/change-cause="nginx:latest"
```
```
kubectl rollout undo deployment -n deploy-ns nginx-deployment --to-revision=2
deployment.apps/nginx-deployment rolled back
```
```
kubectl rollout history deployment  -n deploy-ns
deployment.apps/nginx-deployment
REVISION  CHANGE-CAUSE
1         <none>
3         <none>
4         <none>
```
```
kubectl get rs -n deploy-ns -o wide


NAME                          DESIRED   CURRENT   READY   AGE   CONTAINERS   IMAGES         SELECTOR
nginx-deployment-56c6c88b4b   4         4         4       30m   nginx        nginx:1.16.1   app=nginx,pod-template-hash=56c6c88b4b
nginx-deployment-56cb67986c   0         0         0       47m   nginx        nginx:1.14.2   app=nginx,pod-template-hash=56cb67986c
nginx-deployment-66bfb5c864   0         0         0       10m   nginx        nginx:latest   app=nginx,pod-template-hash=66bfb5c864

```



