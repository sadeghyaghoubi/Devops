اگر سیستم عامل دبیان یا اوبونتو باشد، بسته nginx نصب شود:

```
- name: Install nginx only on Debian-based systems
  apt:
    name: nginx
    state: present
  when: ansible_facts['os_family'] == "Debian"
```
شرط when بررسی می‌کند که آیا سیستم عامل خانواده دبیان است یا خیر.
اگر بله، وظیفه اجرا می‌شود.
