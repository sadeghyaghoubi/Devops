## livenessProbe :
درواقع اینجوریه که میاد یه سرویسیو چک میکنه

مثلا سرویس api GW باید رو پورت 8080 بیاد بالا

آیا این سرویس الان زنده هست اگر نیست ریست میکنه

## readinessProbe :
اینجوریه که میاد میگه قبل اینکه API GW من بیاد بالا اول چک کن ببین دیتابیسم بالا هست یا نه

اگ بالا بود ترافیکو بفرست سمت API GW درغیر این صورت ترافیکی سمت سرویسم نیاد




###

# تمام آپشن‌ها و روش‌های Liveness Probe و Readiness Probe در Kubernetes

در Kubernetes، **Liveness Probe** و **Readiness Probe** از تنظیمات مشابهی استفاده می‌کنند. این تنظیمات مشخص می‌کنند Kubernetes چگونه وضعیت کانتینر را بررسی کند. در این فایل تمامی آپشن‌ها و جزئیات آن‌ها را بررسی می‌کنیم.

---

## ۱. روش‌های بررسی پروب‌ها

Kubernetes از سه روش اصلی برای بررسی پروب‌ها استفاده می‌کند:

### ۱.۱. HTTP GET
- بررسی یک آدرس HTTP/HTTPS در داخل کانتینر.
- اگر پاسخ **200-399** باشد، پروب موفق است. در غیر این صورت، شکست می‌خورد.

```yaml
httpGet:
  path: /healthz  # مسیر بررسی
  port: 8080      # پورت برنامه
  scheme: HTTP    # پروتکل (HTTP یا HTTPS)
  httpHeaders:    # هدرهای HTTP (اختیاری)
  - name: Authorization
    value: Bearer <token>
```

---

### ۱.۲. TCP Socket
- بررسی اتصال به یک پورت خاص در کانتینر.
- اگر اتصال موفق باشد، پروب موفق است.

```yaml
tcpSocket:
  port: 3306  # پورت بررسی
```

---

### ۱.۳. Command Execution
- اجرای یک دستور در کانتینر.
- اگر دستور کد خروجی (exit code) **0** داشته باشد، پروب موفق است.

```yaml
exec:
  command:
  - cat
  - /tmp/healthy
```

---

## ۲. آپشن‌های عمومی پروب‌ها

این تنظیمات در همه انواع پروب‌ها (HTTP، TCP، Exec) قابل استفاده هستند:

| **پارامتر**               | **توضیح**                                                                                     | **پیش‌فرض** |
|----------------------------|----------------------------------------------------------------------------------------------|-------------|
| **`initialDelaySeconds`**  | مدت زمان تأخیر قبل از شروع اولین پروب (پس از راه‌اندازی کانتینر).                              | `0`         |
| **`periodSeconds`**        | فاصله زمانی بین هر پروب.                                                                      | `10`        |
| **`timeoutSeconds`**       | مدت زمان انتظار برای پاسخ پروب. اگر این زمان بگذرد و پاسخی دریافت نشود، پروب شکست می‌خورد.   | `1`         |
| **`successThreshold`**     | تعداد دفعات متوالی موفقیت برای اینکه پروب موفق تلقی شود. (فقط در **Readiness Probe**)        | `1`         |
| **`failureThreshold`**     | تعداد دفعات متوالی شکست برای اینکه پروب ناموفق تلقی شود.                                     | `3`         |

---

## ۳. مثال‌های کاربردی آپشن‌ها

### مثال ۱: HTTP GET Probe
```yaml
livenessProbe:
  httpGet:
    path: /healthz
    port: 8080
  initialDelaySeconds: 5    # ۵ ثانیه صبر قبل از شروع پروب
  periodSeconds: 10         # هر ۱۰ ثانیه یک بار پروب اجرا شود
  timeoutSeconds: 2         # اگر تا ۲ ثانیه پاسخ نداد، پروب شکست بخورد
  failureThreshold: 3       # بعد از ۳ بار شکست متوالی، کانتینر بازنشانی شود
```

### مثال ۲: TCP Socket Probe
```yaml
readinessProbe:
  tcpSocket:
    port: 5432              # بررسی اتصال به پورت ۵۴۳۲ (مثلاً دیتابیس)
  initialDelaySeconds: 10   # شروع بررسی پس از ۱۰ ثانیه
  periodSeconds: 5          # بررسی هر ۵ ثانیه
  timeoutSeconds: 1         # پروب باید در کمتر از ۱ ثانیه پاسخ دهد
  successThreshold: 2       # نیاز به ۲ بار موفقیت متوالی برای آماده اعلام کردن کانتینر
```

### مثال ۳: Exec Probe
```yaml
livenessProbe:
  exec:
    command:
    - sh
    - -c
    - test -f /tmp/healthy  # بررسی وجود فایل /tmp/healthy
  initialDelaySeconds: 15   # صبر ۱۵ ثانیه‌ای برای آماده‌سازی برنامه
  periodSeconds: 10         # اجرای پروب هر ۱۰ ثانیه
  failureThreshold: 5       # بعد از ۵ بار شکست متوالی، کانتینر بازنشانی شود
```

---

## نکات مهم

1. **`initialDelaySeconds`**
   - اگر برنامه شما زمان قابل توجهی برای اجرا شدن نیاز دارد، از این پارامتر استفاده کنید تا پروب‌ها زودتر از موعد شروع نشوند.

2. **`successThreshold`**
   - معمولاً فقط در **Readiness Probe** استفاده می‌شود.
   - وقتی مقدار آن بالاتر از ۱ باشد، پروب باید چند بار متوالی موفق شود تا کانتینر آماده اعلام شود.

3. **`failureThreshold`**
   - اگر پروب چند بار متوالی شکست بخورد (بر اساس این مقدار)، کانتینر بازنشانی (Liveness) یا از سرویس‌دهی خارج (Readiness) می‌شود.

4. **`timeoutSeconds`**
   - برای اطمینان از اینکه پروب‌ها سریع پاسخ می‌دهند. اگر شبکه کند باشد یا برنامه زمان بیشتری نیاز دارد، این مقدار را افزایش دهید.

---

## جمع‌بندی
پروب‌ها در Kubernetes بسیار انعطاف‌پذیر هستند و با ترکیب این آپشن‌ها می‌توانید رفتارهای مختلفی را برای سرویس‌های خود تنظیم کنید. تنظیم درست پروب‌ها نقش مهمی در پایداری و کارآمدی سیستم‌های توزیع‌شده دارد.