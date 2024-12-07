ساختار:
tasks/main.yml


```
- name: نصب Nginx
  apt:
    name: nginx
    state: present

- name: فعال کردن سرویس Nginx
  service:
    name: nginx
    state: started
    enabled: yes
```

main Playbook

```
- name: Playbook اصلی
  hosts: webservers
  tasks:
    - include: tasks/main.yml
```


