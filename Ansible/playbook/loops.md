نصب چند بسته با یک وظیفه:

```
- name: Install multiple packages
  apt:
    name: "{{ item }}"
    state: present
  loop:
    - nginx
    - git
    - curl
```
لیستی از موارد را می‌گیرد و وظیفه را برای هر آیتم اجرا می‌کند.
این مثال سه بسته nginx، git و curl را نصب می‌کند.
