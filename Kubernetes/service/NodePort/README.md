
2. NodePort
کاربرد: این نوع سرویس دسترسی به یک پورت ثابت در هر نود کلاستر را فراهم می‌کند.

توضیح: به شما امکان می‌دهد که با استفاده از IP نود و پورت مشخص‌شده، از خارج از کلاستر به سرویس دسترسی پیدا کنید.

مثال: زمانی که بخواهید بدون تنظیم Load Balancer مستقیماً به سرویس دسترسی داشته باشید.

محدودیت: تعداد پورت‌ها محدود است و نیاز به مدیریت دستی دارد.

سناریو: شما یک برنامه ساده وب (مثلاً یک صفحه HTML) دارید که باید از خارج از کلاستر قابل دسترسی باشد، اما نمی‌خواهید Load Balancer تنظیم کنید.

فایل YAML برای NodePort:
```
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
      nodePort: 30080
  type: NodePort

```
