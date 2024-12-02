# انواع متغیرها در Ansible

در Ansible، متغیرها ابزار مهمی برای مدیریت مقادیر پویای قابل استفاده در Playbook و نقش‌ها هستند. در اینجا انواع متغیرها را با مثال توضیح می‌دهیم.

---

## 1. **متغیرهای تعریف‌شده در Playbook**
می‌توانید مستقیماً در فایل Playbook متغیرها را تعریف کنید.

```yaml
- name: نمونه Playbook
  hosts: all
  vars:
    my_var: "سلام انسیبل"
  tasks:
    - name: نمایش مقدار متغیر
      debug:
        msg: "{{ my_var }}"
```

## 2. متغیرهای تعریف‌شده در فایل‌های Inventory

در فایل Inventory، متغیرها می‌توانند به گروه یا هاست خاصی اختصاص داده شوند.

```
[web]
server1 ansible_host=192.168.1.10 my_var="سلام از اینونتوری"
```


Inventory فایل (yaml):  
```
all:
  hosts:
    server1:
      ansible_host: 192.168.1.10
      my_var: "سلام از اینونتوری YAML"
```

استفاده در Playbook:
```
- name: استفاده از متغیر اینونتوری
  hosts: all
  tasks:
    - name: نمایش مقدار متغیر
      debug:
        msg: "{{ my_var }}"
```

## 3. متغیرهای تعریف‌شده در فایل‌های Group Vars یا Host Vars

می‌توانید برای گروه‌ها یا هاست‌های خاص فایل‌های جداگانه ایجاد کنید.

ساختار دایرکتوری:
```
inventory/
  group_vars/
    all.yml
  host_vars/
    server1.yml
```

محتوای فایل group_vars/all.yml:

```
common_var: "این متغیر برای همه گروه‌هاست"
```

محتوای فایل host_vars/server1.yml:
```
host_specific_var: "این متغیر فقط برای server1 است"
```


## 4. متغیرهای تعریف‌شده در خط فرمان

می‌توانید هنگام اجرای Playbook متغیرها را تعریف کنید.

```
ansible-playbook playbook.yml -e "my_var=متغیر_خط_فرمان"
```

استفاده در Playbook:
```
- name: استفاده از متغیر خط فرمان
  hosts: all
  tasks:
    - name: نمایش مقدار متغیر
      debug:
        msg: "{{ my_var }}"
```

## 5. متغیرهای ثبت‌شده (Registered Variables)

این نوع متغیرها از خروجی یک وظیفه (Task) ساخته می‌شوند.

```
- name: ثبت خروجی یک فرمان
  hosts: all
  tasks:
    - name: اجرای دستور و ثبت خروجی
      command: whoami
      register: command_output

    - name: نمایش خروجی ثبت‌شده
      debug:
        msg: "{{ command_output.stdout }}"
```

## 6. متغیرهای تعریف‌شده در Role

در داخل هر Role می‌توانید متغیرها را در فایل‌های زیر تعریف کنید:


defaults/main.yml: متغیرهای پیش‌فرض.

vars/main.yml: متغیرهای اجباری (اولویت بالاتر).

مثال در Role:
```
# defaults/main.yml
role_default_var: "مقدار پیش‌فرض"
```

نکته مهم: اولویت‌بندی متغیرها :

انسیبل از قانون هرچه نزدیک‌تر، اولویت بالاتر پیروی می‌کند. به این معنی که:

متغیرهای خط فرمان: بالاترین اولویت
متغیرهای defaults: کمترین اولویت

