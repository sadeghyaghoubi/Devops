```
- name: Install Apache on CentOS
  hosts: all
  tasks:
    - name: Install Apache
      yum:
        name: httpd
        state: present
```
