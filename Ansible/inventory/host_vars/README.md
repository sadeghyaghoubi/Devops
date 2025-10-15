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
