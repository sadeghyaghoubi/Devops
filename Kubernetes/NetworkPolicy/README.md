
# Network Policy در Kubernetes

یک ویژگی در Kubernetes است که به شما امکان می‌دهد کنترل کنید که کدام پادها می‌توانند با سایر پادها یا منابع خارجی ارتباط برقرار کنند. این قابلیت برای امنیت شبکه و ایزولاسیون استفاده می‌شود.

---

## **Network Policy چیست؟**

- **Ingress**: کنترل ترافیکی که **به پاد وارد می‌شود**.
- **Egress**: کنترل ترافیکی که **از پاد خارج می‌شود**.

### **چرا Network Policy اهمیت دارد؟**
1. جلوگیری از ارتباطات غیرمجاز.
2. ایزولاسیون بین سرویس‌ها.
3. محدود کردن دسترسی پادها به اینترنت یا منابع خاص.
4. اعمال قوانین دقیق برای ارتباطات شبکه‌ای.

---

## **ساختار Network Policy**

یک Network Policy از اجزای زیر تشکیل شده است:
- **podSelector**: مشخص می‌کند که این Policy روی کدام پادها اعمال شود.
- **policyTypes**: مشخص می‌کند که این Policy برای ترافیک `Ingress`، `Egress` یا هر دو است.
- **ingress/egress**: قوانین مربوط به ترافیک ورودی و خروجی.

---

## **مثال‌های عملی از Network Policy**

### **1. اجازه دسترسی فقط به یک Namespace خاص**

#### سناریو:
فقط پادهای namespace با نام `frontend-namespace` اجازه دارند به پادهای namespace با نام `backend-namespace` متصل شوند.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-namespace
  namespace: backend-namespace
spec:
  podSelector: {}
  policyTypes:
    - Ingress
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              name: frontend-namespace
```

---

### **2. محدود کردن دسترسی به یک Port خاص**

#### سناریو:
فقط پادهای `frontend` اجازه دارند از طریق Port `8080` به `backend` دسترسی داشته باشند.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-specific-port
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: frontend
      ports:
        - protocol: TCP
          port: 8080
```

---

### **3. اجازه دسترسی به یک آی‌پی خاص**

#### سناریو:
پادها فقط باید بتوانند به دیتابیسی در آی‌پی `192.168.1.100` متصل شوند.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-egress-to-ip
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
    - Egress
  egress:
    - to:
        - ipBlock:
            cidr: 192.168.1.100/32
```

---

### **4. مسدود کردن کل ترافیک ورودی**

#### سناریو:
هیچ ترافیکی نباید به پادهای namespace وارد شود.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-ingress
  namespace: default
spec:
  podSelector: {}
  policyTypes:
    - Ingress
  ingress: []
```

---

### **5. مسدود کردن همه ارتباطات بین پادها**

#### سناریو:
هیچ پادی نباید به پاد دیگری در همان namespace متصل شود.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-pod-to-pod
  namespace: default
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
  ingress: []
  egress: []
```

---

### **6. اجازه دسترسی به سرویس DNS**

#### سناریو:
پادها فقط باید بتوانند به سرویس DNS (Port `53`) دسترسی داشته باشند.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-dns
  namespace: default
spec:
  podSelector: {}
  policyTypes:
    - Egress
  egress:
    - to:
        - namespaceSelector:
            matchLabels:
              name: kube-system
        - ports:
            - protocol: UDP
              port: 53
            - protocol: TCP
              port: 53
```

---

### **7. اجازه دسترسی فقط به HTTP (Port 80)**

#### سناریو:
پادها فقط اجازه دارند به منابع HTTP در یک Subnet خاص متصل شوند.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-http-egress
  namespace: default
spec:
  podSelector: {}
  policyTypes:
    - Egress
  egress:
    - to:
        - ipBlock:
            cidr: 10.1.0.0/16
          ports:
            - protocol: TCP
              port: 80
```

---

### **8. اجازه دسترسی فقط بین پادهای با برچسب خاص**

#### سناریو:
پادهایی با برچسب `team: dev` فقط می‌توانند با یکدیگر ارتباط برقرار کنند.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-dev-team
  namespace: default
spec:
  podSelector:
    matchLabels:
      team: dev
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              team: dev
  egress:
    - to:
        - podSelector:
            matchLabels:
              team: dev
```

---

## نکات مهم:
1. Network Policy تنها روی ترافیک لایه 3 و 4 (IP و Port) کار می‌کند.
2. برای اعمال Network Policy، باید CNI Plugin شما (مثل Calico یا Cilium) از آن پشتیبانی کند.
3. اگر هیچ Network Policy وجود نداشته باشد، همه ارتباطات مجاز هستند.

---

### **جمع‌بندی**
Network Policy یک ابزار قدرتمند برای مدیریت و امنیت شبکه در Kubernetes است. با تنظیم قوانین مناسب، می‌توانید دسترسی بین پادها و منابع خارجی را کنترل کنید و از امنیت شبکه‌ی خود اطمینان حاصل کنید.
