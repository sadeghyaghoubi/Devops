Show All list on Ansible 
CLI:
```
ansible-doc -l
```

search for specific module:
```
ansible-doc apt
```

# 🧩 لیست ماژول‌های مهم و پرکاربرد Ansible با مثال

این فایل شامل فهرستی از مهم‌ترین ماژول‌های Ansible به همراه توضیحات و مثال‌های واقعی است.

---

## ۱️⃣ ماژول‌های مدیریت پکیج (Package Management)

| ماژول | کاربرد | مثال |
|--------|----------|--------|
| `apt` | نصب پکیج در Ubuntu/Debian | `apt: name=nginx state=present update_cache=yes` |
| `yum` | نصب پکیج در CentOS/RHEL | `yum: name=httpd state=latest` |
| `dnf` | جایگزین جدید yum در RHEL 8+ | `dnf: name=nginx state=present` |
| `package` | ماژول عمومی برای نصب پکیج‌ها | `package: name=curl state=present` |
| `pip` | نصب پکیج‌های Python | `pip: name=requests state=latest` |

---

## ۲️⃣ ماژول‌های مدیریت سرویس‌ها (Service Management)

| ماژول | کاربرد | مثال |
|--------|----------|--------|
| `service` | کنترل سرویس‌ها (start/stop/restart) | `service: name=nginx state=started enabled=yes` |
| `systemd` | کنترل پیشرفته‌تر سرویس‌ها با systemd | `systemd: name=docker state=restarted daemon_reload=yes` |

---

## ۳️⃣ ماژول‌های فایل و دایرکتوری (File & Directory)

| ماژول | کاربرد | مثال |
|--------|----------|--------|
| `copy` | کپی فایل یا ساخت متن در مقصد | `copy: dest=/etc/motd content="Welcome!"` |
| `template` | کپی فایل Jinja2 با جایگذاری متغیرها | `template: src=index.html.j2 dest=/var/www/html/index.html` |
| `file` | ساخت یا تغییر مجوز فایل و دایرکتوری | `file: path=/opt/myapp state=directory mode='0755'` |
| `fetch` | دانلود فایل از remote host به local | `fetch: src=/etc/hosts dest=backup/ flat=yes` |
| `lineinfile` | تغییر یا اضافه کردن یک خط خاص در فایل | `lineinfile: path=/etc/sysctl.conf line="net.ipv4.ip_forward=1"` |
| `blockinfile` | اضافه کردن بلاک چندخطی در فایل | `blockinfile: path=/etc/nginx/nginx.conf block="server {...}"` |

---

## ۴️⃣ ماژول‌های کاربر و مجوزها (User & Permission)

| ماژول | کاربرد | مثال |
|--------|----------|--------|
| `user` | ایجاد یا حذف کاربر | `user: name=devops shell=/bin/bash state=present` |
| `group` | ایجاد یا حذف گروه | `group: name=admins state=present` |
| `authorized_key` | اضافه کردن کلید SSH برای کاربر | `authorized_key: user=ubuntu key="{{ lookup('file', '~/.ssh/id_rsa.pub') }}"` |

---

## ۵️⃣ ماژول‌های شبکه و فایروال (Network & Firewall)

| ماژول | کاربرد | مثال |
|--------|----------|--------|
| `ufw` | مدیریت فایروال در Ubuntu | `ufw: rule=allow port=80 proto=tcp` |
| `firewalld` | مدیریت فایروال در CentOS/RHEL | `firewalld: service=http permanent=yes state=enabled` |
| `hostname` | تنظیم hostname سیستم | `hostname: name=web1.example.com` |
| `nmcli` | پیکربندی شبکه | `nmcli: conn_name=eth0 state=up` |

---

## ۶️⃣ ماژول‌های فایل فشرده و انتقال فایل (Archive & Transfer)

| ماژول | کاربرد | مثال |
|--------|----------|--------|
| `unarchive` | اکسترکت فایل فشرده | `unarchive: src=/tmp/app.tar.gz dest=/opt/app/ remote_src=yes` |
| `get_url` | دانلود فایل از URL | `get_url: url=https://example.com/file dest=/tmp/file` |
| `git` | کلون یا pull از ریپازیتوری Git | `git: repo=https://github.com/example/app.git dest=/opt/app version=main` |

---

## ۷️⃣ اجرای دستورها (Command Execution)

| ماژول | کاربرد | مثال |
|--------|----------|--------|
| `command` | اجرای دستور ساده (بدون shell) | `command: uptime` |
| `shell` | اجرای دستور با قابلیت shell | `shell: echo hello > /tmp/test.txt` |
| `script` | اجرای اسکریپت محلی روی remote host | `script: files/setup.sh` |

---

## ۸️⃣ ماژول‌های سیستمی (System & Facts)

| ماژول | کاربرد | مثال |
|--------|----------|--------|
| `setup` | جمع‌آوری اطلاعات سیستم (facts) | `setup:` |
| `cron` | زمان‌بندی اجرای دستور | `cron: name="backup" minute=0 hour=2 job="/usr/local/bin/backup.sh"` |
| `reboot` | ریستارت سیستم | `reboot:` |
| `wait_for` | انتظار برای شرایط خاص | `wait_for: port=22 timeout=60` |

---

## ۹️⃣ ماژول‌های مربوط به Docker

| ماژول | کاربرد | مثال |
|--------|----------|--------|
| `docker_container` | مدیریت کانتینرها | `docker_container: name=nginx image=nginx state=started ports="80:80"` |
| `docker_image` | مدیریت ایمیج‌ها | `docker_image: name=nginx source=pull` |

---

## 🔟 ماژول‌های DevOps و منطقی

| ماژول | کاربرد | مثال |
|--------|----------|--------|
| `include_tasks` | وارد کردن مجموعه‌ای از taskها | `include_tasks: setup.yml` |
| `import_role` | اضافه کردن role در حین اجرا | `import_role: name=nginx` |
| `assert` | بررسی شرط‌ها | `assert: that: ansible_os_family == "Debian"` |
| `debug` | چاپ متغیرها | `debug: var=ansible_facts.os_family` |

---

## ⚡ خلاصه تصویری

| دسته | مثال معروف | معادل در ترمینال |
|-------|--------------|------------------|
| Package | `apt`, `yum` | `apt install` |
| Service | `service` | `systemctl start` |
| File | `copy`, `template`, `file` | `cp`, `chmod`, `echo` |
| User | `user`, `authorized_key` | `useradd`, `ssh-copy-id` |
| Network | `ufw`, `firewalld` | `ufw allow` |
| System | `reboot`, `cron` | `reboot`, `crontab -e` |
| Docker | `docker_container` | `docker run` |

---
