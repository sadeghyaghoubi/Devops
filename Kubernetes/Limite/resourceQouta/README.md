در resource qouta محدودیت به این صورته که رو کل name space تمرکز داره .

یعنی ما اگ 50 گیگ منابع به یک name space تخصیص بدیم نمیاد به هر کدوم از پاد ها 50 گیگ محدودیت بذاره .

درواقع میاد مجموع منابع مصرفی تمامی پاد های اون nameSpace بررسی میکنه و اگر به ماکس رسیده باشه دیگه ماشین جدیدی نمیشه ایجاد کرد و احتمال اینکه پاد های موجودهم به مشکل بخورن وجود داره .
```
apiVersion: v1
kind: ResourceQuota
metadata:
  name: compute-quota
  namespace: my-namespace
spec:
  hard:
    requests.cpu: "4"        # مجموع CPU درخواست‌شده توسط همه پادها در Namespace نباید بیشتر از 4 هسته باشد.
    requests.memory: "8Gi"   # مجموع حافظه درخواست‌شده توسط همه پادها نباید بیشتر از 8 گیگابایت باشد.
    limits.cpu: "6"          # مجموع CPU محدود‌شده برای همه پادها نباید بیشتر از 6 هسته باشد.
    limits.memory: "10Gi"    # مجموع حافظه محدود‌شده برای همه پادها نباید بیشتر از 10 گیگابایت باشد.
    pods: "10"               # تعداد کل پادها در این Namespace نباید بیشتر از 10 عدد باشد.
```

```
kubectl apply -f resource-quota.yaml
```

```
kubectl get resourcequota -n my-namespace
```

```
kubectl describe resourcequota compute-quota -n my-namespace
```

