برای ایجاد یا تغییر مجوز و مالکیت فایل/دایرکتوری.

```
- name: Create a directory
  hosts: all
  tasks:
    - name: Create a directory
      file:
        path: /tmp/mydir
        state: directory
        mode: '0755'
```
