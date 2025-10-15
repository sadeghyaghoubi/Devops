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



```
TASK [Show summary] ************************************************************
ok: [web1] => {
    "msg": "Installed nginx on web1 with port 9090"
}
ok: [web2] => {
    "msg": "Installed nginx on web2 with port 8080"
}
```
