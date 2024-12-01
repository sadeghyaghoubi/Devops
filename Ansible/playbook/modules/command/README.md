```
- name: Run uptime command
  hosts: all
  tasks:
    - name: Get uptime
      command: uptime
```
