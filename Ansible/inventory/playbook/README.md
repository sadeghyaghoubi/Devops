```
- name: Configure web servers
  hosts: webservers
  become: yes
  vars:
    package_name: nginx
    service_name: nginx
  roles:
    - nginx

```
