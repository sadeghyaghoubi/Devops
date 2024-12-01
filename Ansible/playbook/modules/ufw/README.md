```
- name: Configure UFW rules
  hosts: all
  tasks:
    - name: Allow HTTP
      ufw:
        rule: allow
        port: 80
```
