```
- name: Copy a file to remote hosts
  hosts: all
  tasks:
    - name: Copy index.html
      copy:
        src: /home/user/index.html
        dest: /var/www/html/index.html
        force: yes
```
