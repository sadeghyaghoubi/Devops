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

```
- name: ایجاد فایل‌ها
  hosts: localhost
  tasks:
    - name: ایجاد فایل‌ها با محتوای مختلف
      copy:
        dest: "/tmp/{{ item }}.txt"
        content: "این فایل برای {{ item }} است."
      with_items:
        - file1
        - file2
        - file3
```

```
- name: پینگ سرورهای مختلف
  hosts: localhost
  tasks:
    - name: بررسی دسترسی به سرورها
      command: ping -c 1 {{ item }}
      with_items:
        - 192.168.1.1
        - 192.168.1.2
        - 192.168.1.3
```
