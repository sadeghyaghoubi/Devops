این نوع براساس استفاده از CPU و رم، تعداد پادهای Deployment یا ReplicaSet را تغییر می‌دهد.

تصور کن یک اپلیکیشن وب داری که در زمان‌های مختلف روز بار ترافیکی متغیری دارد. صبح‌ها و شب‌ها کاربران بیشتری از آن استفاده می‌کنند و ظهرها کمتر.

با استفاده از HPA، می‌توان تنظیم کرد که وقتی استفاده از CPU روی پادها به یک مقدار معین، مثلاً 70%، می‌رسد، کوبرنتیز به صورت خودکار پادهای بیشتری را ایجاد کند تا ترافیک را مدیریت کنند. و وقتی استفاده کاهش می‌یابد، تعداد پادها را کاهش می‌دهد تا منابع هدر نرود. این کار باعث می‌شود که اپلیکیشن همیشه در دسترس باشد و به صورت بهینه از منابع استفاده شود.

```
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: my-deployment-hpa  # نام HPA
  namespace: default       # Namespace که Deployment در آن است
spec:
  scaleTargetRef:
    apiVersion: apps/v1    # نوع ریسورس (Deployment)
    kind: Deployment
    name: my-deployment    # نام Deployment مورد نظر
  minReplicas: 2           # حداقل تعداد پادها
  maxReplicas: 10          # حداکثر تعداد پادها
  metrics:
  - type: Resource
    resource:
      name: cpu            # معیار: CPU
      target:
        type: Utilization
        averageUtilization: 70  # اگر استفاده از CPU بالای 70% شد، مقیاس‌بندی انجام شود
  - type: Resource
    resource:
      name: memory         # معیار: RAM
      target:
        type: AverageValue
        averageValue: 1Gi  # اگر RAM هر پاد بالای 1 گیگ شد، مقیاس‌بندی انجام شود
```



```
kubectl apply -f hpa.yaml
```

```
kubectl get hpa
```

