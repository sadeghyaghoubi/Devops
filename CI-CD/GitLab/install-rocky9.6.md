# نصب GitLab Omnibus روی Rocky Linux 9.6

این سند شامل راهنمای کامل، عملیاتی و Production-Ready برای نصب GitLab به روش **Omnibus** روی Rocky Linux 9.6 است.

---

## پیش‌نیازهای سیستم

### حداقل منابع پیشنهادی
- CPU: حداقل 2 Core (ترجیحاً 4 Core)
- RAM: حداقل 4GB
- Disk: حداقل 20GB (SSD توصیه می‌شود)
- OS: Rocky Linux 9.6 x86_64

---

## 1. بروزرسانی سیستم

```bash
sudo dnf update -y
sudo reboot
```

---

## 2. تنظیم Hostname

```bash
sudo hostnamectl set-hostname gitlab.example.com
hostname -f
```

---

## 3. تنظیم Firewall

```bash
sudo firewall-cmd --permanent --add-service={http,https,ssh}
sudo firewall-cmd --reload
```

---

## 4. نصب وابستگی‌ها

```bash
sudo dnf install -y curl openssh-server ca-certificates policycoreutils perl
sudo systemctl enable --now sshd
```

---

## 5. افزودن مخزن رسمی GitLab

```bash
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
```

---

## 6. نصب GitLab Omnibus

```bash
sudo EXTERNAL_URL="http://gitlab.example.com" dnf install -y gitlab-ce
```

در صورت استفاده از IP:

```bash
sudo EXTERNAL_URL="http://192.168.1.10" dnf install -y gitlab-ce
```

---

## 7. اجرای Reconfigure

```bash
sudo gitlab-ctl reconfigure
```

بررسی وضعیت:

```bash
sudo gitlab-ctl status
```

---

## 8. دریافت رمز عبور اولیه root

```bash
sudo cat /etc/gitlab/initial_root_password
```

> این فایل فقط 24 ساعت در دسترس است.

---

## 9. ورود به پنل GitLab

- URL: http://gitlab.example.com
- Username: root
- Password: رمز دریافت‌شده در مرحله قبل

---

## مسیرهای مهم GitLab

- Data: `/var/opt/gitlab`
- Logs: `/var/log/gitlab`
- Config: `/etc/gitlab/gitlab.rb`

پس از هر تغییر در فایل تنظیمات:

```bash
sudo gitlab-ctl reconfigure
```

---

## بررسی سلامت GitLab

```bash
sudo gitlab-rake gitlab:check SANITIZE=true
```

---

## نکات امنیتی پیشنهادی

- تغییر رمز عبور root بلافاصله بعد از نصب
- ساخت Admin User جداگانه
- غیرفعال‌سازی Public Signup
- فعال‌سازی SSL

---

## جمع‌بندی

روش Omnibus بهترین و پایدارترین راه نصب GitLab روی Rocky Linux 9.6 است و برای اکثر سناریوهای Production و Internal توصیه می‌شود.
