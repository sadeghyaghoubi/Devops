گروه web_servers روی پورت 80 باشه.

گروه dev_servers روی پورت 8080 باشه.

```
ansible-project/
├── ansible.cfg
├── inventory
├── playbook.yml
├── group_vars/
│   ├── web_servers.yml
│   └── dev_servers.yml
└── roles/
    └── nginx/
        ├── tasks/
        │   └── main.yml
        ├── templates/
        │   └── nginx.conf.j2
        └── handlers/
            └── main.yml
```

```
mkdir -p inventory playbooks roles/nginx/tasks group_vars/ roles/nginx/templates roles/nginx/handlers
touch ansible.cfg inventory/hosts.ini playbooks/site.yml roles/nginx/tasks/main.yml roles/nginx/templates/nginx.conf.j2 roles/nginx/handlers/main.yml group_vars/web_servers.yml group_vars/dev_
```


ansible.cfg:
```
[defaults]
inventory = inventory/hosts.ini
roles_path = roles
host_key_checking = False
```


inventory:
```
[web_servers]
192.168.1.10

[dev_servers]
192.168.1.11
```


group_vars/web_servers.yml:
```
nginx_port: 80
welcome_msg: "Welcome to the production web server!"
```


group_vars/dev_servers.yml
```
nginx_port: 8080
welcome_msg: "Hello Developer! This is the dev server."
```


roles/nginx/templates/nginx.conf.j2:
```
server {
    listen {{ nginx_port }};
    server_name _;
    root /var/www/html;

    location / {
        return 200 '{{ welcome_msg }}';
        add_header Content-Type text/plain;
    }
}
```


roles/nginx/tasks/main.yml:
```
- name: Install nginx
  apt:
    name: nginx
    state: present
    update_cache: yes
  become: yes

- name: Deploy nginx config from template
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/sites-available/default
  notify: Restart nginx

- name: Ensure nginx is running
  service:
    name: nginx
    state: started
    enabled: yes
```



roles/nginx/handlers/main.yml:
```
- name: Restart nginx
  service:
    name: nginx
    state: restarted
```


playbook.yml:
```
- name: Configure nginx servers
  hosts: all
  become: yes
  roles:
    - nginx
```




```
ansible-playbook -i inventory playbook.yml

```
