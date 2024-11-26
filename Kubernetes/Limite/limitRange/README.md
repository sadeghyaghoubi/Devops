 در limitRange میگه پادهایی که در این Name Space بیان بالا با این محدودیت های منابعی باید بیان بالا.
 
 حالا اگر بخوایم پادی درست کنیم و تو خودش محدودیتی ایجاد کنیم با این شرایط که : 
 
 منابعی بیش تر از حداکثر بهش تخصیص بدیم و یا کمتر از حداقل بهش تخصیص بدیم پاد با خطا مواجه میشه و ایجاد نمیشه .

```
apiVersion: v1
kind: LimitRange
metadata:
  name: resource-limits
  namespace: my-namespace
spec:
  limits:
  - type: Container
    max:
      cpu: "2"
      memory: "1Gi"
    min:
      cpu: "200m"
      memory: "128Mi"
    default:
      cpu: "1"
      memory: "512Mi"
    defaultRequest:
      cpu: "500m"
      memory: "256Mi"

```

```
kubectl apply -f limitrange.yaml
```

```
kubectl get limitrange -n <namespace>
```
خروجی چیزی شبیه به زیر خواهد بود:

```
NAME              CREATED AT
resource-limits   2024-11-25T10:00:00Z
```

برای مشاهده جزئیات:
```
kubectl describe limitrange resource-limits -n <namespace>
```
