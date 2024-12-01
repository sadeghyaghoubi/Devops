```
- name: Install Apache on Debian
  hosts: all
  tasks:
    - name: Install Apache
      apt:
        name: apache2
        state: present

```
