# ConfigMap برای سرویس Consul در Kubernetes

این راهنما نحوه‌ی ایجاد یک `ConfigMap` برای فایل `consul.json` را توضیح می‌دهد که شامل تنظیمات `Consul` است. همچنین نشان می‌دهد که چگونه می‌توان از نام سرویس به جای IP استفاده کرد.
اینجوریه که ما یک پادی داشتیم که داخلش یک فایلی بود به نام consul.json و میخواستیم این فایلو هروقت خواستیم تغییر بدیم .
درنتیجه باید این فایلو میومدیم بیرون و براش configmap درست میکردیم

## ۱. ایجاد ConfigMap
برای ذخیره‌ی تنظیمات `Consul` به عنوان یک `ConfigMap`، فایل زیر را ایجاد کنید:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: consul-config
  namespace: .........
data:
  consul.json: |
    {
      "ConsulSetting": {
        "Address": "http://SERVICENAME:8500",
        "Token": "...........-...........-...........-.-...........",
        "Path": "Telecom"
      }
    }
```

### اعمال ConfigMap در Kubernetes:
```sh
kubectl apply -f consul-config.yaml
```

---

## ۲. استفاده از ConfigMap در Deployment

فایل `Deployment` را ویرایش کنید و `ConfigMap` را به‌صورت `volume` به کانتینر متصل کنید:

```yaml
spec:
  containers:
  - name: ui-back
    image: .................................
    volumeMounts:
    - name: consul-config-volume
      mountPath: /App/Config/consul.json
      subPath: consul.json
  volumes:
  - name: consul-config-volume
    configMap:
      name: consul-config
```

سپس تغییرات را در Kubernetes اعمال کنید:

```sh
kubectl apply -f deployment.yaml
```

---

## ۳. بررسی مقدار ConfigMap در Pod

پس از استقرار، بررسی کنید که مقدار `ConfigMap` به‌درستی در پاد اعمال شده باشد:

```sh
kubectl exec -it <pod-name> -n kasra -- cat /App/Config/consul.json
```

✅ اگر مقدار `Address` برابر `http://consul-server:8500` بود، تنظیمات به‌درستی اعمال شده‌اند.
