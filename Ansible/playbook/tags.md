برچسب‌ها به شما اجازه می‌دهند که بخش خاصی از پلی‌بوک را اجرا کنید.


دو وظیفه با برچسب‌های مختلف:

```
- name: Install nginx
  apt:
    name: nginx
    state: present
  tags: nginx

- name: Install git
  apt:
    name: git
    state: present
  tags: git
```

برای اجرای وظیفه مربوط به nginx:

```
ansible-playbook playbook.yml --tags nginx
```
