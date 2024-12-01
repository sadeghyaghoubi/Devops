```
- name: Backup a configuration file
  copy:
    src: /etc/myconfig.conf
    dest: /tmp/backup/myconfig.conf
    backup: yes
```
backup: yes: این گزینه باعث می‌شود که اگر فایل در مقصد وجود داشته باشد، نسخه‌ای از آن قبل از کپی شدن به عنوان پشتیبان ذخیره شود.

اگر تغییرات داشته باشیم و اون فایلو بخوایم کاری کنیم قبلش یک بک آپ تو همون مسیر ازش میگیره با نام تاریخ و ساعت همون روز
