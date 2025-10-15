```
ansible-hostvars-demo/
├── inventory
├── group_vars/
│   └── webservers.yml
├── host_vars/
│   └── web1.yml
├── playbooks/
│   └── site.yml
└── roles/
    └── service/
        ├── tasks/main.yml
        └── templates/nginx.conf.j2
```

```
[webservers]
web1 ansible_connection=local
web2 ansible_connection=local
```
group_vars/webservers.yml :
```
package_name: nginx
service_name: nginx
service_port: 8080
config_template: nginx.conf.j2
```

host_vars/web1.yml :
```
service_port: 9090
```
template roles/service/templates/nginx.conf.j2

```
server {
    listen {{ service_port }};
    server_name localhost;

    location / {
        root /var/www/html;
        index index.html;
    }
}
```
tasks/main.yml :
```
- name: Install package (Debian)
  apt:
    name: "{{ package_name }}"
    state: present
  when: ansible_os_family == "Debian"

- name: Start and enable service
  service:
    name: "{{ service_name }}"
    state: started
    enabled: true

- name: Copy config template if defined
  template:
    src: "{{ config_template }}"
    dest: "/etc/{{ service_name }}/{{ service_name }}.conf"
  when: config_template | length > 0
  notify: restart service

- name: Show summary
  debug:
    msg: "Installed {{ package_name }} on {{ inventory_hostname }} with port {{ service_port }}"
```

playbooks/site.yml :

```
- name: Apply service role to all webservers
  hosts: webservers
  become: yes
  roles:
    - service
```
```
ansible-playbook -i inventory playbooks/site.yml
```
```
TASK [Show summary] ************************************************************
ok: [web1] => {
    "msg": "Installed nginx on web1 with port 9090"
}
ok: [web2] => {
    "msg": "Installed nginx on web2 with port 8080"
}
```
