# اضافه کردن Worker Node به Kubernetes Cluster روی Rocky Linux 9.6

این راهنما کل فرآیند اضافه کردن یک Worker Node جدید به کلاستر Kubernetes (ساخته شده با kubeadm) را به‌صورت **Production-Grade** توضیح می‌دهد.

---

## پیش‌فرض‌ها

- سیستم‌عامل: Rocky Linux 9.6
- Kubernetes: kubeadm-based
- Container Runtime: containerd
- یک Master (Control Plane) فعال داریم

---

## 1. آماده‌سازی اولیه سیستم عامل (Worker جدید)

### تنظیم hostname
```bash
hostnamectl set-hostname worker2.example.com
reboot
```

### تنظیم DNS یا `/etc/hosts`
روی تمام نودها:

```bash
vi /etc/hosts
```

```text
192.168.10.10 master1.example.com
192.168.10.21 worker1.example.com
192.168.10.22 worker2.example.com
```

---

## 2. غیرفعال‌سازی Swap (الزامی)

```bash
swapoff -a
sed -i '/swap/d' /etc/fstab
```

بررسی:
```bash
swapon --show
```

---

## 3. تنظیم Kernel Modules و sysctl

```bash
cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter
```

```bash
cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system
```

---

## 4. نصب containerd (Container Runtime)

### اضافه کردن Docker Repo
```bash
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

### نصب containerd
```bash
dnf install -y containerd.io
```

### کانفیگ containerd
```bash
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml
```

ویرایش فایل:
```bash
vi /etc/containerd/config.toml
```

اطمینان از:
```toml
SystemdCgroup = true
```

### فعال‌سازی سرویس
```bash
systemctl enable --now containerd
```

---

## 5. نصب Kubernetes Components

```bash
cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
EOF
```

```bash
dnf install -y kubelet kubeadm kubectl
systemctl enable --now kubelet
```

---

## 6. Join کردن Worker به کلاستر

### روی Master Node
```bash
kubeadm token create --print-join-command
```

### روی Worker جدید
```bash
kubeadm join <MASTER_IP>:6443  --token <TOKEN>  --discovery-token-ca-cert-hash sha256:<HASH>
```

---

## 7. وضعیت kubelet قبل از Join (نکته مهم)

قبل از Join شدن، kubelet به‌صورت زیر دیده می‌شود:

```text
Active: activating (auto-restart)
```

✅ این وضعیت **طبیعی** است.

---

## 8. بررسی نهایی

روی Master:

```bash
kubectl get nodes -o wide
```

وضعیت درست:
```text
worker2   Ready   <none>
```

اگر `NotReady` بود، ۱–۲ دقیقه صبر کنید تا CNI بالا بیاید.

---

## 9. خطاهای رایج

### Node در وضعیت NotReady
- معمولاً CNI هنوز Deploy نشده
- Firewalld فعال است

```bash
systemctl stop firewalld
systemctl disable firewalld
```

### بررسی CNI
```bash
kubectl get pods -n kube-system
```

---

## 10. پیشنهادهای Production

- یکسان‌سازی نسخه Kubernetes بین Master و Workerها
- Label کردن Worker جدید
```bash
kubectl label node worker2.example.com role=worker
```

- تست Scheduling
```bash
kubectl run nginx --image=nginx --restart=Never
```

---

## جمع‌بندی

✅ Join موفق
✅ Network Ready
✅ Worker آماده دریافت workload

---
