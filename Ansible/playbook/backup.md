```
- name: Backup a configuration file
  copy:
    src: /etc/myconfig.conf
    dest: /tmp/backup/myconfig.conf
    backup: yes
  ```

قبل اینکه کاری انجام بده میاد یک بک آپ از فایل میگیره و تو همون مسیری که هست میریزه  با نام تاریخ و ساعت همون روز
