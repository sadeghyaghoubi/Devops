
# ماژول Template در انسیبل: توضیح و مثال

## ماژول `template` چیست؟
ماژول `template` در انسیبل برای ایجاد یا مدیریت فایل‌ها به صورت پویا استفاده می‌شود. این ماژول با جایگذاری مقادیر متغیرها در فایل‌های **Jinja2 template**، فایل‌های پیکربندی یا متنی خاصی را برای میزبان‌های هدف تولید می‌کند.

---

## کاربرد
فرض کنید می‌خواهید فایل‌های پیکربندی **Nginx** را برای چندین سرور ایجاد کنید، به گونه‌ای که:
- هر سرور نام میزبان (hostname) منحصر به فردی داشته باشد.
- هر سرور دارای آدرس IP متفاوتی باشد.

با استفاده از ماژول `template`، می‌توانید این فایل‌ها را به صورت خودکار و پویا تولید کنید.

---

## مراحل پیاده‌سازی

### 1. ایجاد فایل Template
ابتدا فایل Template خود را به صورت زیر ایجاد کنید و آن را با نام **`nginx.conf.j2`** ذخیره کنید:

```nginx
server {
    listen 80;
    server_name {{ inventory_hostname }};
    
    location / {
        proxy_pass http://{{ ansible_host }};
    }

    error_log /var/log/nginx/{{ inventory_hostname }}.error.log;
    access_log /var/log/nginx/{{ inventory_hostname }}.access.log;
}
```

- `{{ inventory_hostname }}`: نام میزبان از فایل موجودی (Inventory) را جایگزین می‌کند.
- `{{ ansible_host }}`: آدرس IP میزبان را جایگزین می‌کند.

---

### 2. ایجاد فایل موجودی (Inventory)
فایل موجودی را برای تعریف میزبان‌ها و آدرس‌های آن‌ها به صورت زیر ایجاد کنید:

**`inventory.ini`**
```ini
[webservers]
web1 ansible_host=192.168.1.101
web2 ansible_host=192.168.1.102
```

---

### 3. نوشتن Playbook
در Playbook از ماژول `template` استفاده کنید تا فایل‌های پیکربندی برای هر میزبان ایجاد شود:

**`nginx.yml`**
```yaml
- name: پیکربندی Nginx برای سرورهای وب
  hosts: webservers
  become: yes
  tasks:
    - name: کپی فایل پیکربندی Nginx
      template:
        src: templates/nginx.conf.j2
        dest: /etc/nginx/conf.d/{{ inventory_hostname }}.conf
        owner: root
        group: root
        mode: '0644'

    - name: راه‌اندازی مجدد سرویس Nginx
      service:
        name: nginx
        state: restarted
```

- **`src`**: مسیر فایل Template روی کنترل‌کننده انسیبل.
- **`dest`**: مسیر فایل نهایی روی میزبان هدف.
- **`owner`**، **`group`** و **`mode`**: تنظیم مالکیت و دسترسی فایل.

---

### 4. اجرای Playbook
برای اجرای Playbook از دستور زیر استفاده کنید:

```bash
ansible-playbook nginx.yml
```

---

## نتیجه
1. برای هر میزبان در گروه `webservers`، یک فایل پیکربندی ایجاد می‌شود:
   - `/etc/nginx/conf.d/web1.conf`
   - `/etc/nginx/conf.d/web2.conf`

2. محتوای فایل برای میزبان `web1` به شکل زیر خواهد بود:

   **/etc/nginx/conf.d/web1.conf**
   ```nginx
   server {
       listen 80;
       server_name web1;

       location / {
           proxy_pass http://192.168.1.101;
       }

       error_log /var/log/nginx/web1.error.log;
       access_log /var/log/nginx/web1.access.log;
   }
   ```

3. سرویس Nginx روی هر میزبان با پیکربندی جدید راه‌اندازی می‌شود.

---

## مزایای استفاده از ماژول `template`
- **پیکربندی پویا:** تنظیم فایل‌ها بر اساس متغیرهای خاص هر میزبان.
- **قابلیت استفاده مجدد:** یک Template برای چندین میزبان قابل استفاده است.
- **اتوماتیک‌سازی:** نیازی به ویرایش دستی فایل‌ها نیست.

---

### نکات اضافی
- Templateها از **Jinja2 syntax** پشتیبانی می‌کنند و می‌توانید از دستورات شرطی، حلقه‌ها و فیلترها استفاده کنید.
- قبل از اعمال تغییرات، با دستور `ansible-playbook --check` تغییرات را پیش‌نمایش کنید.
- برای مدیریت دسترسی فایل‌ها، از تنظیمات `owner`، `group` و `mode` استفاده کنید.

---
