برای مدیریت سرویس‌ها.

```
- name: Start and enable nginx
  hosts: all
  tasks:
    - name: Ensure nginx is running
      service:
        name: nginx
        state: started
        enabled: yes
```
