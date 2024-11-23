'''
1 : With command:
```
kubectl set image deployments -n deploy-ns nginx-deployment nginx=nginx:1.20.0
```

'''
2 : Change Yaml File :

add this command :
```
spec:
  .
  .
  .
  image: nginx:1.20.0  # تغییر نسخه ایمیج

  .
  .
  .
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1  # حداکثر تعداد پادهای که می‌توانند در هنگام به‌روزرسانی از دسترس خارج شوند
      maxSurge: 1        # حداکثر تعداد پادهای که می‌توانند بیش از مقدار مشخص‌شده در حال به‌روزرسانی باشند
  minReadySeconds: 10  # حداقل زمانی که پاد باید در حالت "آماده" باشد
