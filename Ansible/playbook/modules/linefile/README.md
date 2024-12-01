
# تغییرات در فایل‌ها با استفاده از Ansible

در Ansible، ماژول‌های مختلفی برای تغییر، حذف یا جایگزینی خطوط در یک فایل وجود دارد. در اینجا نحوه استفاده از ماژول‌های `lineinfile` و `replace` برای این تغییرات توضیح داده می‌شود.

## 1. حذف یک خط خاص
برای حذف یک خط خاص از فایل، می‌توانید از ماژول **`lineinfile`** استفاده کنید و گزینه `state: absent` را تنظیم کنید. در این حالت، با استفاده از **`regexp`** خط مورد نظر شناسایی شده و حذف می‌شود.

### مثال: حذف یک خط خاص از فایل
```yaml
- name: Remove a specific line from the file
  lineinfile:
    path: /etc/myconfig.conf
    regexp: '^mysetting=true'
    state: absent
```

در اینجا:
- `regexp`: الگوی جستجو برای خطی است که می‌خواهید حذف کنید.
- `state: absent`: مشخص می‌کند که باید خطی که با الگوی `regexp` تطبیق دارد، حذف شود.

## 2. تغییر یک خط خاص
برای تغییر یک خط خاص در فایل، می‌توانید از همان ماژول **`lineinfile`** استفاده کنید و گزینه `line` را با مقدار جدید تنظیم کنید. اگر خطی که می‌خواهید تغییر دهید وجود داشته باشد، آن را با خط جدید جایگزین می‌کند.

### مثال: تغییر یک خط خاص در فایل
```yaml
- name: Change a specific line in the file
  lineinfile:
    path: /etc/myconfig.conf
    regexp: '^mysetting=true'
    line: 'mysetting=false'
```

در اینجا:
- `regexp`: الگوی جستجو برای خطی است که می‌خواهید تغییر دهید.
- `line`: مقدار جدیدی است که باید جایگزین خط قدیمی شود.

## 3. افزودن یک خط جدید
اگر خطی با شرایط خاص وجود نداشته باشد و بخواهید آن را اضافه کنید، می‌توانید از **`lineinfile`** با `state: present` استفاده کنید.

### مثال: افزودن خط جدید به فایل
```yaml
- name: Add a line to the file if it doesn't exist
  lineinfile:
    path: /etc/myconfig.conf
    line: 'mysetting=true'
    state: present
```

## 4. استفاده از ماژول `replace`
اگر نیاز دارید تا مقدار خاصی را در داخل فایل به صورت دقیق‌تر جایگزین کنید، می‌توانید از ماژول **`replace`** استفاده کنید.

### مثال: تغییر مقدار در داخل فایل
```yaml
- name: Replace oldvalue with newvalue in the file
  replace:
    path: /etc/myconfig.conf
    regexp: 'oldvalue'
    replace: 'newvalue'
```

## نکات:
- **`lineinfile`** بیشتر برای کار با خطوط خاص استفاده می‌شود.
- **`replace`** برای جستجو و جایگزینی بخش‌های خاص از متن در فایل کاربرد دارد.
- با استفاده از **`regexp`** می‌توانید الگوهای پیچیده‌تری برای شناسایی خطوط استفاده کنید.
