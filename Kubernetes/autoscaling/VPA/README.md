این نوع به صورت خودکار منابع (مثل CPU و رم) تخصیص داده شده به پادها را براساس نیازهایشان افزایش یا کاهش می‌دهد. 

فرض کن یک پاد داری که یک اپلیکیشن پردازش تصویر را اجرا می‌کند. در برخی مواقع، این اپلیکیشن نیاز به منابع CPU و رم بیشتری دارد.

با استفاده از VPA، می‌توانید تنظیم کنید که کوبرنتیز به صورت خودکار منابع تخصیص داده شده به پاد را افزایش دهد. مثلاً، اگر اپلیکیشن شروع به پردازش تصاویر حجیم کند و نیاز به رم بیشتری داشته باشد به صورت خودکار منابع افزایش پیدا میکند .

نکته : 
اگر محدودیت (Limit) تعیین کرده‌اید: وقتی کانتینر به سقف دو گیگابایت رم برسد و همچنان نیاز به رم بیشتری داشته باشد، ممکن است کرش کند (Out of Memory - OOM) و از نو راه‌اندازی شود. این رفتار به دلیل Limit اعمال‌شده است.

مراحل پیاده‌سازی Vertical Pod Autoscaler
پیش‌نیازها:

نصب VPA Admission Controller روی کلاستر Kubernetes :
git clone https://github.com/kubernetes/autoscaler.git
cd autoscaler/vertical-pod-autoscaler
git checkout origin/vpa-release-1.0
REGISTRY=registry.k8s.io/autoscaling TAG=1.0.0 ./hack/vpa-process-yamls.sh apply


مطمئن شوید که metrics-server در کلاستر نصب شده است.


```
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: nginx-vpa
  namespace: default
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: nginx-deployment
  updatePolicy:
    updateMode: "Auto" # می‌تواند "Off", "Initial", یا "Auto" باشد
  resourcePolicy:
    containerPolicies:
    - containerName: nginx
      minAllowed:
        cpu: "100m"         # حداقل CPU
        memory: "64Mi"      # حداقل حافظه
      maxAllowed:
        cpu: "1"            # حداکثر CPU
        memory: "512Mi"     # حداکثر حافظه
      controlledResources: ["cpu", "memory"]
```

targetRef: مشخص می‌کند که VPA روی کدام منبع اعمال شود (مثلاً Deployment).

updatePolicy.updateMode:

Off: فقط پیشنهادات (recommendations) ارائه می‌شود، ولی منابع پادها به‌روزرسانی نمی‌شوند.

Initial: منابع فقط هنگام ایجاد پاد جدید بهینه می‌شوند.

Auto: منابع پادهای در حال اجرا به‌طور خودکار بهینه می‌شوند.

```
kubectl apply -f vpa.yaml
```

```
kubectl describe vpa nginx-vpa
```


اگر مصرف واقعی پاد زیر minAllowed باشد، VPA پیشنهاد می‌دهد مقدار منابع را به minAllowed افزایش دهد.

اگر مصرف واقعی بالای maxAllowed برود، VPA مقدار را به maxAllowed محدود می‌کند.

اگر مصرف بین minAllowed و maxAllowed باشد، مقدار دقیق منابع را بر اساس target utilization پیشنهاد می‌دهد.

